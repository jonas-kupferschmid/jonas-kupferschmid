
# ===== 02. internalnetwork搭建 =====
# ⚠️ 已经跑完 01 服务器搭建 的 检测阿里云源,替换为官方源
# ⚠️⚠️⚠️ 修改internalnetwork_setup.sh ⚠️⚠️⚠️

SERVER_NAME="AliCloudSingapore"
ADMIN_USER="root"
# 本地电脑=====
scp internalnetwork_setup.sh $SERVER_NAME:/$ADMIN_USER

# 连接服务器
ssh $SERVER_NAME

# =====服务器上=====
ls -l *.sh
chmod +x internalnetwork_setup.sh
./internalnetwork_setup.sh
# !!! on alicloud console need to activate firewall rule because it has its own security group
# !!! 阿里云上面需要在控制台编辑防火墙规则