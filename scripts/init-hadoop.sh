#! /bin/bash

MIRROR="https://mirrors.tuna.tsinghua.edu.cn"
VERSION="3.2.1"
HADOOP="hadoop-${VERSION}"
FILENAME="${HADOOP}.tar.gz"
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

cd /tmp
echo "=== Downloading ${FILENAME} ==="
curl "${MIRROR}/apache/hadoop/common/${HADOOP}/${FILENAME}" -o ${FILENAME}
echo "=== Extracting files from ${FILENAME} ==="
tar -zxf ${FILENAME} -C /opt
ln -s /opt/${HADOOP} /opt/hadoop

echo "=== Adding Environment Varibles ${FILENAME} ==="
echo "export JAVA_HOME=${JAVA_HOME}"
sed -i "/export JAVA_HOME=$/c\export JAVA_HOME=${JAVA_HOME}" /opt/hadoop/etc/hadoop/hadoop-env.sh
cd /opt/hadoop/sbin
for i in *dfs.sh; do
  sed -i '8i \
HDFS_DATANODE_USER=root\
HADOOP_SECURE_DN_USER=hdfs\
HDFS_NAMENODE_USER=root\
HDFS_SECONDARYNAMENODE_USER=root' $i
done
for i in *yarn.sh; do
  sed -i '8i \
YARN_RESOURCEMANAGER_USER=root\
HADOOP_SECURE_DN_USER=yarn\
YARN_NODEMANAGER_USER=root' $i
done

echo "export PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH" | tee -a ~/.bashrc

echo "=== Copying Hadoop configs ==="
cp /src/configs/hadoop/* /opt/hadoop/etc/hadoop/
