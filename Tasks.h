#ifndef TASKS_H
#define TASKS_H
#include <QString>
#include <QVariant>
#include <QMap>
#include "TaskInterFace.h"

template <typename It>
class Tasks :public TaskInterFace {

public:
    Tasks(const QMap<QString, It> &data, qint64 id, int status = false)
        : map(data), ID(id), Status(status) {}

    QVariant get(const QString &key) const override {

        if (key == "status") return Status;
        if (key == "id")     return  ID;
        return QVariant::fromValue(map.value(key));
    }

    void set(const QString &key, const QVariant &value) override {
        if (key == "status") Status = value.toInt();

        map[key] = value.value<It>();
    }

    QMap<QString, QVariant> getAttributes() const override {
        QMap<QString, QVariant> converted;
        for (auto it = map.begin(); it != map.end(); ++it)
            converted[it.key()] = QVariant::fromValue(it.value());
        return converted;
    }

    qint64 getId() const override { return ID; }
    int getStatus() const override { return Status; }

    It getTyped(const QString &key) const {
        return map.value(key);
    }


private:
    QMap<QString, It> map;
    qint64 ID;
    int Status;
};

#endif
