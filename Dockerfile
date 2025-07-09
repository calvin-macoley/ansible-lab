FROM ubuntu:latest
USER root
# -y to avoid interactive cli
RUN apt-get update && apt-get install -y openssh-server && apt-get install -y python3 && apt-get install -y python3-apt

# Create SSH host keys and configure SSH
RUN mkdir -p /var/run/sshd && \
    ssh-keygen -A && \
    echo 'root:<your_password>' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Create startup script to run both services
RUN echo '#!/bin/bash\n\
# Start SSH daemon in background\n\
/usr/sbin/sshd -D &\n\
\n\
# Start Apache in foreground\n\
httpd-foreground' > /start.\chmod +x /start.sh

EXPOSE 80
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
