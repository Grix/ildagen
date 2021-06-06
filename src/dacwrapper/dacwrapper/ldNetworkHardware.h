#ifndef LDNETWORKHARDWARE_H
#define LDNETWORKHARDWARE_H

#include "wobjectdefs.h"
#include "LaserDockNetworkDevice.h"


enum class Status { UNKNOWN, INITIALIZED };

W_REGISTER_ARGTYPE(Status)


class ldNetworkHardware : public QObject {

    W_OBJECT(ldNetworkHardware)

public:
    struct device_params {

        uint32_t ilda_rate = 30000;

        LaserdockNetworkDevice *device = nullptr;
    };

    //enum class Status { UNKNOWN, INITIALIZED };

    ldNetworkHardware(LaserdockNetworkDevice *device, QObject *parent = nullptr);
    ~ldNetworkHardware();


    device_params params;

    bool send(LaserdockSample* samples, unsigned int count);
    void initialize();

    virtual QString id() const;
    Status status();

    void send_security_request(QByteArray request);
    void get_security_response(QByteArray &response);

//    const device_params &params() const;

    //bool send_samples(uint startIndex, uint count);
    bool send_samples(LaserdockSample *samples, unsigned int size);

    int  get_full_count();
    void ResetStatus();

    void setStatus(Status status);

    bool isActive() const;
    void setActive(bool active);

    bool m_isActive = false;


//signals:
    void deviceDisconnected() W_SIGNAL(deviceDisconnected)
    void statusChanged(Status status) W_SIGNAL(statusChanged, status)

private:
   //QScopedPointer<ldNetworkHardwarePrivate> d_ptr;
   Status m_status = Status::UNKNOWN;
   //Q_DECLARE_PRIVATE(ldNetworkHardware)
};


#endif // LDNETWORKHARDWARE_H
