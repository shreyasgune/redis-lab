FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache curl unzip bash vim

# Define versions (check GitHub releases for the absolute latest if needed)
ARG TOFU_VERSION="1.6.2"
ARG TERRAGRUNT_VERSION="0.57.1"
ARG TARGETARCH="amd64"

# Download and install OpenTofu
RUN echo "Downloading OpenTofu v${TOFU_VERSION} for linux/${TARGETARCH}..." && \
    curl -fsSLO "https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_linux_${TARGETARCH}.zip" && \
    echo "Installing OpenTofu..." && \
    unzip "tofu_${TOFU_VERSION}_linux_${TARGETARCH}.zip" -d /usr/local/bin && \
    rm "tofu_${TOFU_VERSION}_linux_${TARGETARCH}.zip"

# Download and install Terragrunt
RUN echo "Downloading Terragrunt v${TERRAGRUNT_VERSION} for linux/${TARGETARCH}..." && \
    curl -fsSLO "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_${TARGETARCH}" && \
    echo "Installing Terragrunt..." && \
    chmod +x "terragrunt_linux_${TARGETARCH}" && \
    mv "terragrunt_linux_${TARGETARCH}" /usr/local/bin/terragrunt

# Verification nation
RUN echo "Verifying installations..." && \
    tofu --version && \
    terragrunt --version

# Clean up apk cache
RUN rm -rf /var/cache/apk/*

# CMD ["/bin/bash"] 