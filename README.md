####  可以下载了
#### 前端部分
确保你已经安装了 Node.js 和 npm。
进入前端项目目录：
``` java
cd nursing-center-system/nursing-center-frontend
```
##### 安装依赖：
``` java
npm install
```
##### 启动开发服务器：
``` java
npm run serve
或者
npm run dev
```
访问前端页面：
默认地址：http://localhost:8080
后端部分
确保你已经安装了以下工具：
JDK 8 或更高版本
Maven
MySQL
数据库设置：
创建一个 MySQL 数据库。
在 nursing-center-system/src/main/resources/application.yml 中，配置数据库连接信息：
``` java
YAML
    spring:
      datasource:
        url: jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC
        username: your_database_user
        password: your_database_password
```
编译并运行：
进入后端项目目录：
``` java
cd nursing-center-system
``` 
使用 Maven 编译项目：
``` java
mvn clean install
```
启动后端服务：
``` java
mvn spring-boot:run
```
