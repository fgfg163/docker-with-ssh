docker 中安装 ssh 的 demo
#### 注意
1. 文件换行应使用 LF 风格而不是 CRLF 。否则 centos 中无法运行
2. docker 镜像不能保存进程的运行状态，因此需要在 Dockerfile 的 CMD 中启动所有进程。

### 使用步骤
1. 构建镜像，密码在 dockerfile 中修改
```bash
docker build -t withssh:1 .

```

2. 创建容器
```bash
docker run -p 8022:22 -itd withssh:1
```

3. 在主机中登录

*. 查看容器 ip
```bash
docker inspect --format='{{.NetworkSettings.IPAddress}}' $(docker ps -a -q) 
```
