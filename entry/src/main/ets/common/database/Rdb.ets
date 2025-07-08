import relationalStore from '@ohos.data.relationalStore';

// 定义数据库配置接口
interface StoreConfig {
  name: string;
  securityLevel: relationalStore.SecurityLevel;
}

// 定义用户数据接口
interface UserData {
  username: string;
  password: string;
}

export class Rdb {
  private rdbStore: relationalStore.RdbStore | null = null;
  private readonly tableName: string = 'USER_TABLE';
  private readonly sqlCreateTable: string = 'CREATE TABLE IF NOT EXISTS USER_TABLE (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, password TEXT NOT NULL)';

  constructor(callback: () => void = () => {}) {
    this.getRdbStore(() => {
      this.createTable(() => {
        callback();
      });
    });
  }

  public getRdbStore(callback: () => void = () => {}): void {
    if (this.rdbStore !== null) {
      callback();
      return;
    }

    const config: StoreConfig = {
      name: 'user.db',
      securityLevel: relationalStore.SecurityLevel.S1
    };

    relationalStore.getRdbStore(getContext(this), config, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore, code is ${err.code}, message is ${err.message}`);
        return;
      }
      this.rdbStore = store;
      callback();
    });
  }

  private createTable(callback: () => void = () => {}): void {
    if (this.rdbStore === null) {
      console.error('RdbStore is not ready');
      return;
    }
    this.rdbStore.executeSql(this.sqlCreateTable);
    callback();
  }

  // 插入用户数据
  public insertData(user: UserData, callback: (success: boolean) => void): void {
    if (this.rdbStore === null) {
      console.error('RdbStore is not ready');
      callback(false);
      return;
    }

    const valueBucket: relationalStore.ValuesBucket = {
      'username': user.username,
      'password': user.password
    };

    this.rdbStore.insert(this.tableName, valueBucket, (err, rowId) => {
      if (err) {
        console.error(`Failed to insert data, code is ${err.code}, message is ${err.message}`);
        callback(false);
        return;
      }
      console.info(`Succeeded in inserting data, rowId = ${rowId}`);
      callback(true);
    });
  }

  // 查询用户
  public queryUser(username: string, password: string, callback: (success: boolean) => void): void {
    if (this.rdbStore === null) {
      console.error('RdbStore is not ready');
      callback(false);
      return;
    }

    const predicates = new relationalStore.RdbPredicates(this.tableName);
    predicates.equalTo('username', username).and().equalTo('password', password);

    this.rdbStore.query(predicates, ['id', 'username', 'password'], (err, resultSet) => {
      if (err) {
        console.error(`Failed to query data, code is ${err.code}, message is ${err.message}`);
        callback(false);
        return;
      }
      callback(resultSet.rowCount > 0);
      resultSet.close();
    });
  }

  // 检查用户名是否存在
  public checkUsername(username: string, callback: (exists: boolean) => void): void {
    if (this.rdbStore === null) {
      console.error('RdbStore is not ready');
      callback(false);
      return;
    }

    const predicates = new relationalStore.RdbPredicates(this.tableName);
    predicates.equalTo('username', username);

    this.rdbStore.query(predicates, ['username'], (err, resultSet) => {
      if (err) {
        console.error(`Failed to query data, code is ${err.code}, message is ${err.message}`);
        callback(false);
        return;
      }
      callback(resultSet.rowCount > 0);
      resultSet.close();
    });
  }
}

export default new Rdb(); 