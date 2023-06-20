FROM gitpod/workspace-dotnet

USER gitpod 

ENV DOTNET_VERSION=6.0.100
ENV DOTNET_ROOT=/workspace/.dotnet
ENV PATH=$DOTNET_ROOT:$PATH

RUN mkdir -p $DOTNET_ROOT && curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version $DOTNET_VERSION --install-dir $DOTNET_ROOT 
RUN sudo ln -s /workspace/.dotnet/dotnet /usr/bin/dotnet