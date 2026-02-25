#include "modeljira.h"
#include "Tasks.h"
#include <QDebug>
#include <QTimer>


ModelJira::ModelJira(QObject *parent )
    :QAbstractListModel(parent)
{

}


//Returns the number of tasks in the model.
int ModelJira::rowCount(const QModelIndex &parent) const{
    if (parent.isValid()) return 0;

       qDebug() << "Row Count:" << m_items.size();

    return  m_items.size();
}

//Returns the value of a task's attribute based on row and role.
QVariant ModelJira::data(const QModelIndex &index, int role) const {
    if(!index.isValid() || index.row() < 0 || index.row() >= m_items.size())
        return QVariant();

    TaskInterFace *Task = m_items.at(index.row());

    auto RoleMap = roleNames();
    if (RoleMap.contains(role)){
        QVariant value = Task->get(RoleMap[role]);

        //                qDebug() << "Row :" << index.row();
        //                qDebug() << "Role :" << RoleMap[role] << "Valu :" << value;

        return value;
    }

    return QVariant();
}

//Maps role IDs to role names for QML access.Tells Qt/QML what text name each role has.
QHash <int , QByteArray> ModelJira::roleNames() const{
    QHash <int , QByteArray> role;

    role[IdRole]         = "id";
    role[NameRole]       = "name";
    role[DescriptionRole]="description";
    role[StatusRole]     = "status";


    return role;

}

Q_INVOKABLE bool ModelJira::createTask(const QString &name , const QString &desc , int Status ){
    if (name == "") return  false;
    qint64 newId = generator++;

    //    qDebug() << "Name:" << name;
    //    qDebug() << "Description:" << desc;
    //    qDebug() << "Status:" << Status;

    QMap <QString , QString> data;
    data["name"]=name;
    data["description"]=desc;


    TaskInterFace *task_Ob = new Tasks <QString>(data , newId , Status);

    userAdded = false;

    if (task_Ob){
        userAdded = true;
        setUserAdded(userAdded);
        startTimer();
    }

    return  addTask(task_Ob);

}
bool ModelJira::addTask(TaskInterFace *Task){
    if (!Task) return  false;

    //    QMap<QString ,QVariant> attr = Task->getAttributes();
    //    for(auto it = attr.begin(); it != attr.end(); ++it  )
    //        qDebug() << it.key() << ":" << it.value();
    //        qDebug() << "Status:"<< Task->getStatus() ;
    //        qDebug() << "ID:" << Task->getId();

    beginInsertRows(QModelIndex(),m_items.size(),m_items.size());
    m_items.append(Task);
    endInsertRows();

    return true;
}

//Removes a task at a specific row and notifies views
bool ModelJira::removeTask(int row){
    if(row < 0 || row >= m_items.size())
        return false;

    beginRemoveRows(QModelIndex(), row, row);
    m_items.removeAt(row);
    endRemoveRows();

    for (int i = row; i < m_items.size(); ++i) {
        m_items[i]->set("id", i + 1);
        QModelIndex idx = createIndex(i, 0);
        emit dataChanged(idx, idx, {IdRole});
    }

    generator = m_items.size() + 1;

    return true;
}



//Clears all tasks from the model and resets the view
bool ModelJira::clear(){
    beginResetModel();
    m_items.clear();
    endResetModel();

    return true;
}

//Updates task attributes at a given row and emits dataChanged
bool ModelJira::setData(const QModelIndex &index, const QVariant &value, int role) {
    //    qDebug() << "Row:" << index.row() << "Role:" << role  << "Value:" << value;

    if (!index.isValid() || index.row() < 0 || index.row() >= m_items.size()) {
        //        qDebug() << "Invalid index!";
        return false;
    }

    TaskInterFace *Task = m_items.at(index.row());

    auto RoleMap = roleNames();
    if (RoleMap.contains(role)) {
        //        qDebug() << "Setting key:" << RoleMap[role] << "with value:" << value;
        Task->set(RoleMap[role], value);
        emit dataChanged(index, index, QVector<int>() << role);
        //        qDebug() << "Data set successfully!";
        return true;
    }

    //    qDebug() << "Role not found!";
    return false;
}


Qt::ItemFlags ModelJira::flags(const QModelIndex &index) const{
    if (!index.isValid()) return Qt::NoItemFlags;

    return Qt::ItemIsSelectable| Qt::ItemIsEnabled |Qt::ItemIsEditable;
}


//Returns all attributes of a task at a specific row
QMap<QString , QVariant> ModelJira::getTask(int row) const{
    if(row<0||row>=m_items.size())
        return {};

    return m_items[row]->getAttributes();
}

void ModelJira :: startTimer(){
    if (timer){
        timer -> start(1000);
    }
}

void ModelJira :: stopTimer(){
    if (timer){
        timer -> stop();
    }
}
void ModelJira::setUserAdded(bool value){
    userAdded = value;
    if (value){
       startTimer();
    }else {
        stopTimer();
    }
}

void ModelJira::UpdateTimer(){
    if (userAdded){
        remainingTime --;
        if (remainingTime < 0){
            remainingTime = 0 ;
            emit remainingTimeChanged(remainingTime);
        }
    }
}

void ModelJira::setRmainingTime (int time){
    remainingTime = time;
}
