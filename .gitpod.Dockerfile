FROM gitpod/workspace-full

USER gitpod

# Downgrade the Java version so that it's compatible with PetClinic
RUN bash -c "curl -fsSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 6.0 --install-dir /home/gitpod/dotnet"
RUN bash -c "export PATH=/home/gitpod/dotnet:$PATH" 

RUN npx playwright install-deps