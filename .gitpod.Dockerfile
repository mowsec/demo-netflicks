FROM gitpod/workspace-dotnet

USER gitpod 

ENV DOTNET_VERSION=6.0.100
ENV DOTNET_ROOT=/workspace/.dotnet
ENV PATH=$DOTNET_ROOT:$PATH

RUN curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version $DOTNET_VERSION --install-dir $DOTNET_ROOT 