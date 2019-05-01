FROM centos:7.6.1810


# 使用163源，更新快
ADD ./CentOS7-Base-163.repo /etc/yum.repos.d/CentOS7-Base.repo
ADD ./start.sh /root/start.sh

RUN yum makecache \
&& chmod 777 /root/start.sh

RUN yum -y update

RUN yum install -y openssh-server \
&& mkdir -p /var/run/sshd \
&& mkdir -p /root/.ssh/ \
# 修改root密码，便于远程登录
&& /bin/echo /bin/echo "test" | passwd --stdin root \
# 配置ssh可以使用root登陆
&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key \
&& ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key \

&& /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd \
&& /bin/sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
&& /bin/sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

# 开放22端口
EXPOSE 22

CMD ["/root/start.sh"]