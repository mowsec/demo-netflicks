# Contrast Security Instrumentation Workshop: Netflicks

## Introduction to Application Security via Instrumentation & Observability

Traditional SAST & DAST security tools typically struggle with the speed of DevOps. Organisations need to shift to developer-centric application security based on instrumentation & observability. This reduces the level of noise and delays of the traditional approaches. IAST uses instrumentation to help developers and QA teams find vulnerabilities early and by providing a full dataflow the fix is fast too.

In this workshop you’ll get hands-on experience with IAST, SCA & RASP. We help you onboard an application, find vulnerabilities, review the results and (if you feel adventurous) exploit them and see how RASP defends against it.

### About Contrast Security

Contrast Security is the leader in modernized application security, embedding code analysis and attack prevention directly into software with patented security instrumentation technology.

[Find out more about Contrast on our website.](https://www.contrastsecurity.com/contrast-assess)

### About Netflicks

TODO

## Prerequisites

1. **A Contrast Security Account**: You'll need a Contrast Security account to manage your applications and view vulnerability reports and attack events.

   * If you are an existing customer or have a POV evaluation with Contrast, please log in to your existing account.
   * If you are attending a workshop, a signup link will be provided.
   * If you don't yet have an account, you can sign up for our [Community Edition](https://www.contrastsecurity.com/contrast-community-edition) for limited access for one application (supports Java and .NET). [Or get in touch for a demo and free evaluation licence.](https://www.contrastsecurity.com/request-demo)

2. **A GitPod Account**: You'll need to sign up to [GitPod.io](gitpod.io) with a GitHub, GitLab or BitBucket account to run the workshop in GitPod. Signup is free.

## Launch the workshop in GitPod (Recommended)

Click the button below to start the workshop in GitPod, which is preconfigured with everything you need. GitPod will launch VS Code in the browser that you can use to change source code and configuration, run commands in a terminal and view the running application in a preview window.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/mowsec/demo-netflicks)

## Launch the workshop locally

You can also run this workshop locally if you prefer. Clone the repo and perform the usual steps to install dependencies and run the app, before continuing with the rest of the workshop guide below.

<details>

<summary>Installing the workshop locally</summary>

(**WARNING:** The computer running this application will be vulnerable to attacks, please take appropriate precautions.)

TODO

<summary>Running the workshop locally in docker compose</summary>

Running the workshop in Docker will isolate it from your environment. The Docker images contain all the dependancies required for the workshop. Run the commands below to build the containers and run the app.

1. **Build and run the application and database in docker compose**

```bash
docker compose up --build
```

2. **Browse to the application at `localhost:5000`**

</details>

---

# Workshop Guide

## Getting Started

Once GitPod has loaded your workspace, you'll notice two services are running in the terminal:

* A MySQL database running on port `1433`
* A Netflicks application server running on port `5000`

Take some time to familiarise yourself with the VS Code editor, the terminal and the running application. Browse around the app and log in using some of the following credentials:

* Username:Password
* TODO

You can stop these services at any time by entering `Ctrl + C` in the terminal.

## Installing the Contrast Security Agent

To get started with Contrast, you'll need to download and install the agent packages from the package manager. Use NPM to download the agent for Node applications:

```bash { closeTerminalOnSuccess=false interactive=false }
dotnet add package Contrast.SensorsNetCore
```

## Configuring the Contrast Security Agent

Next, we need to configure the Contrast Agent with authentication keys, general configuration (such as logging and proxy configuration), and application specific configuration (such as setting an name, environment and agent mode).

All configuration options can be set in a YAML configuration file and via Environment Variables, and the agent uses this [order of precedence](https://docs.contrastsecurity.com/en/order-of-precedence.html). We recommend setting configuration as follows:

1. **Environment Variables** for authentication keys and application specific values, or to overwrite a base configuration set in the YAML file.
2. **YAML configuration file** for general configuration

For more information on configuring the agent, please see:

* [Configure the Node.js agent](https://docs.contrastsecurity.com/en/node-js-configuration.html)
* [Contrast agent configuration editor](https://agent.config.contrastsecurity.com:443/#mode=share&language=nodejs&content=784%40IyBBZ2VudCBhdXRoZW50aWNhdGlvbiBjb25maWd1cmF0aW9uCiMgU2V0IHRoaXMgaW4gdGhlIHlhbWwgaGVyZSwgb3IgdXNlIGVudmlyb25tZW50IHZhcmlhYmxlcyBpbnN0ZWFkLgphcGk6CiAgdXJsOiBodHRwczovL2FwcC5jb250cmFzdHNlY3VyaXR5LmNvbS9Db250cmFzdC8KICBhcGlfa2V5OiBUT0RPCiAgc2VydmljZV9rZXk6IFRPRE8KICB1c2VyX25hbWU6IFRPRE8KCiMgQXBwbGljYXRpb24gY29uZmlndXJhdGlvbiBvcHRpb25zIAojIFRlbGxzIENvbnRyYXN0IGhvdyB0byBkaXNwbGF5IHlvdXIgYXBwbGljYXRpb24gaW4gdGhlIHBsYXRmb3JtLgphcHBsaWNhdGlvbjoKICBuYW1lOiBUT0RPCiAgdmVyc2lvbjogVE9ETwogIHRhZ3M6IFRPRE8KCiMgU2VydmVyIGNvbmZpZ3VyYXRpb24gb3B0aW9ucwojIFRlbGxzIGNvbnRyYXN0IGFib3V0IHRoZSBzZXJ2ZXIgYW5kIGVudmlyb25tZW50LiAKIyBVc2UgdGhpcyB0byBjaGFuZ2UgYmV0d2VlZW4gQXNzZXNzIGFuZCBQcm90ZWN0LgpzZXJ2ZXI6CiAgbmFtZTogbG9jYWxob3N0CiAgZW52aXJvbm1lbnQ6IGRldmVsb3BtZW50CgojIEFnZW50IGNvbmZpZ3VyYXRpb24gb3B0aW9ucwojIFNldCB1cCBhZ2VudCBsb2dnaW5nIAphZ2VudDoKICBsb2dnZXI6CiAgICBwYXRoOiAuL2NvbnRyYXN0X2FnZW50LmxvZwogICAgbGV2ZWw6IElORk8KICAgIHN0ZG91dDogZmFsc2UKICAgIHN0ZGVycjogZmFsc2UKICBzZWN1cml0eV9sb2dnZXI6CiAgICBwYXRoOiAvLmNvbnRyYXN0L3NlY3VyaXR5LmxvZwogICAgbGV2ZWw6IEVSUk9SCg)

### Add a `contrast_security.yaml` file

Add a YAML configuration file for your general agent configuration. This file can either be placed in the applications root directory (`./`) or in the default location for the agent (`/etc/contrast/contrast_security.yaml`).

Add the following basic configration for your app:

```yaml
api:
  url: https://app.contrastsecurity.com/Contrast/
  api_key: TODO
  service_key: TODO
  user_name: TODO
application:
  name: Netflicks-Workshop-<initials>
server:
  name: Netflicks-Workshop-<initials>
  environment: development
```

### Add Environment Variables for application specific configuration

Now we'll add our agent authentication keys and some other configuration values by setting environment variables.

Typically, you would export environment variables by running the following command:

```bash
export CONTRAST__API__URL=XXXXXXXXXXXXXXXXXXX
```

However, GitPod provies a way to securely set these environment variables using the `gp env` command. This will save your Contrast environment variables in your GitPod account for this workspace.

Set the following environment variables, adding your contrast API keys, to complete the configuration of the Contrast Agent:

```bash { closeTerminalOnSuccess=false interactive=false }
export CORECLR_ENABLE_PROFILING=1
export CORECLR_PROFILER={8B2CE134-0948-48CA-A4B2-80DDAD9F5791}
export CORECLR_PROFILER_PATH=./contrast/runtimes/linux-x64/native/ContrastProfiler.so
export CONTRAST_CONFIG_PATH=./contrast_security.yaml
```

## Starting the app with Contrast

Now that the agent has been configured with authentication keys and some basic settings, we can start the application with the Contrast Agent enabled.

First stop the application using `Ctrl+C` if it is still running.

**Run the app with Contrast form the command line**

```bash { closeTerminalOnSuccess=false interactive=true }
dotnet run --project "DotNetFlicks.Web/Web.csproj"
```

Browse the running application via the Simple Browser tab.

You can confirm that the application is running with the contrast agent by checking in the Contrast Security Platform to ensure your new application has been registered. Also, some Contrast output will be visible in the logs for the application if it started successfully.

## Testing your application with Contrast IAST

Interactive Application Security Testing (IAST) works by observing application behaviour at runtime to identify vulnerabilities as you interact with the application. To start analysis, all you need to do is start browsing around the application to exercise routes and the agent will analyse each request and how the application responds. Routes can also be exercised by automated functional testing such as integration and end-to-end tests.

### Test the application manually

Try logging in to the application using the supplied credentials, create a new account for yourself via the register page and then login and back out. View some of the other pages and functionality in the app.

When you're done exploring the application, look at the Contrast Platform for your applciation to see if any vulnerabilities were detected.

### Test the application with automated tests

This container includes cypress to run automated tests. These can be run using:

```bash
npm install playwright
npm run playwright
```

Once the tests have completed, check back in the Contrast Platform to see if any additional vulnerabilities were detected.

Contrast measures Route Coverage too, which tracks the application routes that have been tested, and those which tests miss. Try to exersise any missing routes.

## Defending your application with Contrast RASP

Runtime Application Self-Protection (RASP) uses instrumentation in a similar way to IAST, but instead of trying to find vulnerabilities in pre-production, it's designed to detect and block attacks in production applications.

To see how this works, we need to change some agent configuration to tell it to run in Protect mode.

1. Stop the running application using `Ctrl+C`
2. Edit the `contrast_security.yaml` file to change the `server.name` and `server.environment` to production values. This will automatically instruct the agent to run in Protect mode.

```yaml
application:
    name: Netflicks-Workshop-<initials>
server:
    name: Netflicks-Workshop-<initials>-Prod
    environment: production
```

3. Save the file and restart the application.
4. In the Contrast Platform, you'll see that the production column is now showing that Protect is enabled.

### Attacking the application

Attempt to exploit your application to see how the Contrast Agent detects and reports this.

There is a tutorial available from the home page of WebGoat which will guide you through some attakcs.

### Configuring Protect to Block attacks

By default, Contrast Protect runs in Monitor mode to begin with. This will identify attacks and notify you without interfering with the application.

You can change the Policy for the application to run in Block mode on the Application > Policy > Protect page.

In Blocking mode, the agent will raise an exception within the application (500) if a successful attack is detected. THis prevents the attacker from performing any adverse actions against the application.

Enable Blocking mode now and try the attacks again to see how the agent responds.

## Contrast Reporting

Contrast can export vulnerability information and reports in a number of ways.
