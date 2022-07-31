FROM gitpod/workspace-full

# Note: duplicated from ave Dockerfile:
# https://www.github.com/TamaMcGlinn/ave
RUN sudo apt-get update \
 && sudo apt-get install -y \
    git wget unzip \
 && sudo rm -rf /var/lib/apt/lists/*

RUN sudo mkdir /tools
WORKDIR /tools

# Install alire
RUN sudo wget https://github.com/alire-project/alire/releases/download/v1.2.0/alr-1.2.0-x86_64.AppImage -O /tools/alr
RUN sudo chmod +x /tools/alr
RUN echo "#!/bin/bash\n/tools/alr --appimage-extract-and-run \$@" | sudo tee /usr/bin/alr
RUN sudo chmod +x /usr/bin/alr
RUN sudo alr toolchain --select gnat_native
RUN sudo alr toolchain --select gprbuild

# Install ada_language_server
RUN sudo mkdir -p /root/.local/bin/
RUN sudo wget https://open-vsx.org/api/AdaCore/ada/22.0.8/file/AdaCore.ada-22.0.8.vsix -O als.zip
RUN sudo mkdir ada_language_server
RUN sudo unzip als.zip -d ada_language_server
RUN sudo rm als.zip
RUN sudo chmod +x /tools/ada_language_server/extension/linux/ada_language_server 
RUN sudo ln -s "/tools/ada_language_server/extension/linux/ada_language_server" /usr/bin/ada_language_server
