#ifndef TASKINTERFACE_H
#define TASKINTERFACE_H

#include <QString>
#include <QVariant>
#include <QMap>

class TaskInterFace {

public:
    virtual ~ TaskInterFace() {};
    virtual QVariant get(const QString &key) const =0;
    virtual qint64 getId() const =0;
    virtual int getStatus() const =0;
    virtual void set( const QString &key , const QVariant &newV )  =0;
    virtual  QMap <QString , QVariant> getAttributes() const =0;

};

#endif // TASKINTERFACE_H
