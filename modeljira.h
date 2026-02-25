#ifndef MODELJIRA_H
#define MODELJIRA_H
#include <TaskInterFace.h>

#include <QAbstractListModel>
#include <QList>
#include <QHash>
#include <QMap>
#include <QTimer>

class ModelJira :public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int IdRole MEMBER IdRole CONSTANT)
    Q_PROPERTY(int NameRole MEMBER NameRole CONSTANT)
    Q_PROPERTY(int DescriptionRole MEMBER DescriptionRole CONSTANT)
    Q_PROPERTY(int StatusRole MEMBER StatusRole CONSTANT)
public:
    explicit ModelJira(QObject *parent =Q_NULLPTR);
    int rowCount(const QModelIndex &parent =QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash <int , QByteArray> roleNames() const override;
    Q_INVOKABLE bool createTask(const QString &name , const QString &desc , int Status );
    bool addTask (TaskInterFace* Task);
    Q_INVOKABLE bool removeTask(int row);
    Q_INVOKABLE bool clear();
    Q_INVOKABLE bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Q_INVOKABLE QMap<QString,QVariant> getTask(int row) const;
    Qt::ItemFlags flags(const QModelIndex &index) const;
    void startTimer ();
    void stopTimer ();
    void setUserAdded(bool value);
    void UpdateTimer();
    void setRmainingTime (int time);
    enum TaskRoles {
        IdRole,
        NameRole = Qt::DisplayRole+1,
        DescriptionRole,
        StatusRole
    };

 signals:
    void remainingTimeChanged( int time);

private:
    QList<TaskInterFace*> m_items;
    QList<qint64> freeIds;
    qint64 generator = 1;
    bool userAdded = false;
    QTimer *timer = nullptr;
    int remainingTime = 0;

};

#endif // MODELJIRA_H
