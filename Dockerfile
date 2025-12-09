FROM jenkins/jenkins:lts

USER root

# 安装 Docker CLI 和构建工具
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release   

# 安装 Docker CLI
RUN mkdir -m 0755 -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# 配置 Jenkins 用户到 docker 组
#RUN usermod -aG docker jenkins

# 切换回 jenkins 用户
USER jenkins