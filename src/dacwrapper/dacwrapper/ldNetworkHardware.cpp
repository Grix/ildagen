#include "ldNetworkHardware.h"

#include <QtCore\QtDebug>

ldNetworkHardware::ldNetworkHardware(LaserdockNetworkDevice *device, QObject *parent) // : ldNetworkHardware(parent)
  //,  d_ptr(new ldNetworkHardwarePrivate(this))
{
    params.device = device;    
}

void ldNetworkHardware::setActive(bool active)
{
    bool rc = false;
    rc = active ? params.device->enable_output() : params.device->disable_output();
    if (!rc)
    {
        qWarning() << "Setting output failed";
        return;
    }


     qDebug() << "Output enable was set to:" << active;
     m_isActive = active;
}


void ldNetworkHardware::initialize() {
    bool rc;
    rc = params.device->disable_output();
    if (!rc)
    {
        qWarning() << "Disable output failed";
        return;
    }
    qDebug() << "Disable output worked";

    qDebug() << "===Running===";

    rc = params.device->enable_buffer_state_replies();


    rc = params.device->set_dac_rate(params.ilda_rate);
    if (!rc)
    {
        qWarning() << "setting ILDA rate failed";
        return;
    }

    qDebug() << "Setting ILDA rate worked:" << params.ilda_rate << "pps";

    /*

     // this is now done in overidden setActive function
    uint32_t enable = 1;
    rc = enable ? params.device->enable_output() : params.device->disable_output();
    if (!rc)
    {
        qWarning() << "Setting output failed";
        return;
    }

    if (enable) {
        qDebug() << "Setting output output worked:" << enable;
    }
    */

    setStatus(Status::INITIALIZED);
    //q->setStatus(ldHardware::Status::UNKNOWN);
}

bool ldNetworkHardware::send(LaserdockSample* samples, unsigned int count) {

    //        Q_Q(ldUsbHardware);

            // dirty conversion from ldCompressedSample to LaserdockSample...
    return params.device->send_samples(samples, count);
}

void ldNetworkHardware::ResetStatus()
{
    setStatus(Status::UNKNOWN);
    params.device->ResetStatus();
}

ldNetworkHardware::~ldNetworkHardware()
{
    //Q_D(ldNetworkHardware);
    //setActive(false);
    if(params.device) {
        delete params.device;
    }
}

void ldNetworkHardware::setStatus(Status status)
{
    if (m_status == status) {
        return;
    }

    m_status = status;

    emit statusChanged(status);
}

Status ldNetworkHardware::status()
{
    return m_status;
}

QString ldNetworkHardware::id() const
{
    return params.device->get_ip_address();
}

/*bool ldNetworkHardware::send_samples(uint startIndex, uint count)
{
    Q_ASSERT((startIndex + count < m_compressed_buffer.size())
             || (count == 0));

    if(count > 0)
        return send_samples((LaserdockSample*) &m_compressed_buffer[startIndex], count);
    else
        return send_samples(nullptr, 0);
}*/

bool ldNetworkHardware::send_samples(LaserdockSample *samples, unsigned int size){
    //Q_D(ldNetworkHardware);
    bool ok = send(samples, size);

    if(ok==false) {
        setStatus(Status::UNKNOWN);
        emit deviceDisconnected();
    }
    return ok;
}


bool ldNetworkHardware::isActive() const
{
    return m_isActive;
}


int ldNetworkHardware::get_full_count() {
    //Q_D(ldNetworkHardware);

    uint32_t sample_space_left = 0;
    uint32_t remote_buffer_size_samples = 0;

    // get the sample space left in the buffer
    bool ret1 = params.device->ringbuffer_empty_sample_count(&sample_space_left);
    if (!ret1) return -1;
    ret1=params.device->ringbuffer_sample_count(&remote_buffer_size_samples);
    if (!ret1) return -1;

    //qDebug() <<  free;
    //if (!ret1) return -1;

    //return count1;

    int rbuffer = remote_buffer_size_samples - sample_space_left; // calc num samples currently in buffer
    rbuffer = std::max(rbuffer, -1);
    rbuffer = std::min(rbuffer, (int)remote_buffer_size_samples);

    //qDebug() << "samples currently in remote sample buffer:" << rbuffer;
    return rbuffer;
}

/*const ldNetworkHardware::device_params &ldNetworkHardware::params() const{
    //Q_D(const ldNetworkHardware);
    return params;
}*/


#include "wobjectimpl.h"
W_OBJECT_IMPL(ldNetworkHardware)