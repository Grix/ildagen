#ifndef LDNETWORKHARDWAREMANAGER_H
#define LDNETWORKHARDWAREMANAGER_H

#include "wobjectdefs.h"
#include <memory>

#include <QtCore/QMutex>
#include <QtCore/QObject>
#include <QtCore/QMetaObject>
#include <QtCore/QTimer>
#include <QtNetwork\QUdpSocket>

#include "LaserDockNetworkDevice.h"
#include "ldNetworkHardware.h"

#include <QtCore\QThread>

typedef bool (*ldNetworkAuthenticateCallbackFunc)(ldNetworkHardware *device);

typedef QByteArray (*ldGenerateSecurityRequestCallbackFunc)();
typedef bool (*ldAuthenticateSecurityResponseCallbackFunc)(const QByteArray &resData);

W_REGISTER_ARGTYPE(LaserdockNetworkDevice&)
W_REGISTER_ARGTYPE(bool&)
W_REGISTER_ARGTYPE(QByteArray&)

class ldNetworkHardwareManager : public QObject //: public ldAbstractHardwareManager
{
    W_OBJECT(ldNetworkHardwareManager)
    //W_PROPERTY(bool, isActive MEMBER _isActive NOTIFY isActiveChanged)

public:
    explicit ldNetworkHardwareManager(QObject *parent = nullptr);
    ~ldNetworkHardwareManager();

    struct DeviceBufferConfig {
        uint samples_per_packet; // how many samples to send
        int remote_buffer_cutoff; // this sets the buffer point at which we stop sending to remote device
        int wait_connect_sleep_ms;
        int wait_buffer_sleep_ms;
        int sleep_after_packet_send_ms; // how long to sleep thread for after sending data to a device (in ms)
        uint max_samples_per_udp_xfer; // max number of samples to transmit over any single UDP transer (set to 0 for USB devices)
        uint max_udp_packets_per_xfer;
    };


    int getBufferFullCount();

    bool hasActiveDevices() const;

    bool isDeviceActive(int index) const;
    void setDeviceActive(int index, bool active);

    //void sendData(uint startIndex, uint count) ;
    void sendData(LaserdockSample* samples, uint32_t count);

    virtual void setConnectedDevicesActive(bool active);

    virtual uint deviceCount() const;
    virtual std::vector<ldNetworkHardware*> devices() const;

    virtual DeviceBufferConfig getBufferConfig() ;

    static void setGenerateSecurityRequestCb(ldGenerateSecurityRequestCallbackFunc authenticateFunc);
    static void setAuthenticateSecurityCb(ldAuthenticateSecurityResponseCallbackFunc checkFunc);


public: //slots:
    //virtual void setConnectedDevicesActive(bool active) = 0;
    void setExplicitActiveDevice(int index); W_SLOT(setExplicitActiveDevice)

    //signals:
    void deviceCountChanged(uint deviceCount) W_SIGNAL(deviceCountChanged, deviceCount)

private:
    //signals:
    void ConnectedDevicesActiveChanged(bool active) W_SIGNAL(deviceCountChanged, active)

private:// slots:
    void init(); W_SLOT(init)
    void ConnectedDevicesActiveUpdate(bool active); W_SLOT(ConnectedDevicesActiveUpdate)
    void networkDeviceDisconnectCheck(); W_SLOT(networkDeviceDisconnectCheck)
    void networkDeviceCheck(); W_SLOT(networkDeviceCheck)
    void readPendingDeviceResponses(); W_SLOT(readPendingDeviceResponses)// handles incoming responses to our pings for devices on the network
    void DeviceAuthenticateRequest(LaserdockNetworkDevice &device); W_SLOT(DeviceAuthenticateRequest)
    void DeviceAuthenticateResponse(LaserdockNetworkDevice &device,bool&success, QByteArray& response_data); W_SLOT(DeviceAuthenticateResponse)
protected:
    int m_explicitHardwareIndex = -1;
private:
    void updateCheckTimerState();
    void updateBufferingStrategy(QList<LaserdockNetworkDevice::ConnectionType> &contypes);
    //void updateHardwareFilters();
    void AddNetworkDevice(QString& ip_addr);

    mutable QMutex m_mutex;

    //ldFilterManager *m_filterManager;
    QThread m_managerworkerthread;
    QTimer *m_checkTimer;
    QUdpSocket *m_pingskt;


    bool isActive = true;

    static ldGenerateSecurityRequestCallbackFunc m_genSecReqCb;
    static ldAuthenticateSecurityResponseCallbackFunc m_authSecRespCb;


    std::vector<std::unique_ptr<ldNetworkHardware> > m_initializingnetworkHardwares; // somewhere to store new hardware while it is being initialized
    std::vector<std::unique_ptr<ldNetworkHardware> > m_networkHardwares; // once a network hardware has succesully initialized, it is stored here

#if defined(Q_OS_ANDROID)
      const DeviceBufferConfig m_wifi_server_device_config{300,2400,12,4,2,140,10}; // buffering strategy for a wifi server network cube
      const DeviceBufferConfig m_wifi_server_client_device_config{600,2500,12,5,10,140,10}; // buffering strategy for a wifi server/client(s) network cube
      const DeviceBufferConfig m_wifi_client_device_config{300,3000,12,2,2,100,20}; // buffering strategy for a wifi client network cube
      const DeviceBufferConfig m_wifi_dual_client_device_config{300,4000,12,2,2,100,10}; // buffering strategy for a wifi client network cube
      const DeviceBufferConfig m_lan_server_device_config{300,1800,12,4,2,140,10}; // buffering strategy for ethernet server network cube
      const DeviceBufferConfig m_lan_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for ethernet client network cube
      const DeviceBufferConfig m_lan_dual_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for ethernet client network cube
#elif defined(Q_OS_IOS)
    const DeviceBufferConfig m_wifi_server_device_config{300,3000,12,8,8,140,20}; // buffering strategy for a wifi server network cube
    const DeviceBufferConfig m_wifi_server_client_device_config{700,2800,12,10,10,140,10}; // buffering strategy for a wifi server network cube
    const DeviceBufferConfig m_wifi_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for a wifi client network cube
    const DeviceBufferConfig m_wifi_dual_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for a wifi client network cube
    const DeviceBufferConfig m_lan_server_device_config{300,1800,12,4,2,140,10}; // buffering strategy for ethernet server network cube
    const DeviceBufferConfig m_lan_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for ethernet client network cube
    const DeviceBufferConfig m_lan_dual_client_device_config{300,2400,12,4,2,140,10}; // buffering strategy for ethernet client network cube
#else

    const DeviceBufferConfig m_wifi_server_device_config{600,2000,12,4,10,140,20}; // buffering strategy for a wifi server network cube
    const DeviceBufferConfig m_wifi_server_client_device_config{600,2500,12,5,10,140,10}; // buffering strategy for a wifi server/client(s) network cube
    const DeviceBufferConfig m_wifi_client_device_config{700,1800,12,6,4,80,20}; // buffering strategy for a wifi client network cube
    const DeviceBufferConfig m_wifi_dual_client_device_config{700,1500,12,6,8,140,10}; // buffering strategy for 2x wifi client network cube
    const DeviceBufferConfig m_lan_server_device_config{700,1800,12,6,4,80,20}; // buffering strategy for ethernet server network cube
    const DeviceBufferConfig m_lan_client_device_config{700,1800,12,6,4,80,20}; // buffering strategy for ethernet client network cube
    const DeviceBufferConfig m_lan_dual_client_device_config{700,1800,12,6,4,140,10}; // buffering strategy for ethernet client network cube
#endif

    const DeviceBufferConfig* m_currentBufferConfig{nullptr}; // points to the currently selected device buffering configuration
};

#endif // LDNETWORKHARDWAREMANAGER_H
