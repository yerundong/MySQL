**停止/启动MySQL服务（需要管理员身份运行cmd）**

```cmd
net stop/start [serverName]
```

或者打开windows服务界面，手动开启。



**查看数据库版本**

```cmd
mysql --version
mysql --V
```



**登录MySQL服务**

- 第一种方式：使用MySql Command Line Client，直接打开，输入密码，但只限root用户

- 第二种方式：使用cmd

  格式：`mysql -h[hostName] -P[port] -u[userName] -p[password]`

  注：

  -h：host主机名；-P：port端口号；-u：user用户名；-p：密码； 

  [password]可以省略，执行使用暗文输入；

  如果是本机登录，可省略 -h[hostName] -P[port]，如：mysql -u[userName] -p[password]

  示例：

  ```cmd
  mysql -hlocalhost -P3306 -uroot -p
  mysql -uroot -p
  ```

> 注意：登录服务后才可以使用sql命令

