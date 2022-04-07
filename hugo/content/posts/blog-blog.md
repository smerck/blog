+++
title = "Creating a Blog for fun and profit"
date = "2019-01-25"
author = "Stephan Mercatoris"
cover = "hello.jpg"
description = "For a long time i've wanted to create my own blog for my personal projects, so here we are!"
+++

# Intro

There was a part of my life where I used to mock technical people that hosted their own blogs. I often saw this as gloryhounding or attention seeking (there's some truth to that), but it _can_ be more.

As detailed on my About(link) page, I've filled a number of roles in my career, primarily focused around networking, reliability, public & private cloud infrastructure, kubernetes, and developer advocacy. For years, I've loved digging into topics that i'm not as familiar with and expanding upon my current skillset. I've never really written about these exploits, and wanted to create a place where I could discuss the topics i'm interested in as well as furthering my own skillset. Expect an unreasonable number of memes along the way.

# Static Site Generator - Hugo

image -- a long time ago in a galaxy far, far away
image -- a long time ago (november), in a kubernetes cluster far, far away

Having never really built a blog before, i started with some basic research on blogging platforms that currently exist and the ease of getting them running. I fully plan for this blog to go through multiple iterations and potentially run across multiple platforms over time. That being said, I believe that just hosting a simple blog gives a decent exercise in the basics on cloud infrastrucutre, development practices, and can be uplifted to run on various platforms (bare metal, cloud compute instances, hosted & local kubernetes). For the time being, i've selected Hugo as my static site generator powering this blog. I've done some frontend development in the past, and this is not my favorite topic, so I wanted to pick a static site generator that was super simple and easy.

image -- hugo

Hugo is fast, simple, and easy to use. I have some confidence that given it's simplicity, I can run this as a stateless service across a number of platforms for demonstration purposes without expending too much effort to just standup a service.

Further Reading:
- Hugo documentation

## Running hugo locally

1) Install hugo locally
2) Select a theme
3) Run hugo draft server
4) Adding content

# Platform - Digital Ocean Apps

Initially, I tried running this on a Digital Ocean Kubernetes cluster, but that was too expensive for the purposes of a simple blog like this. For the time being, i've resorted to running this as a Digital Ocean app, but will likely select different platforms for personal learning and content generation purposes.

Adding a Digital Ocean App is pretty straightforward. You can either publish a static site or a containerized app directly through this without having to go through the complexity of kubernetes, and at a lower cost. While I wouldn't be willing to give up this level of control & visibility into a production application, for the purposes of a personal blog, this works great! Additionally, the cost of the blog is significantly lower when run as an app versus running on Digital Ocean managed kubernetes cluster. After running the blog on kubernetes and as a DO App, I can do some quick comparison between costs.

Pros:
- DO Apps are siginficantly cheaper than a managed k8s cluster for this purpose.
- DO Apps are significant simpler and easier to setup than Kubernetes.
- This is a personal blog and high availability/control/visibility is not my current concern.
- Integrates with source control (Github) and automatically updates when a change is pushed to main.

Cons:
- Less control & visibility over the application.

Further reading:
- Digital Ocean Apps
- Digital Ocean Kubernetes

## Adding hugo to DO Apps

Digital Ocean has documentation around adding adding hugo to Digital Ocean Apps either through a Dockerfile or a Cloud Native Buildpack. I've composed my hugo server as a dockerfile in this case.

Further Reading:
- Hugo on Digital Ocean apps: https://docs.digitalocean.com/products/app-platform/languages-frameworks/hugo/

# Infrastructure - DO Apps, Docker, Terraform

While I've opted to deploy this on Digital Ocean Apps, I will be doing so with terraform to enforce an Infrastructure-As-Code standard on how this blog is updated & deployed. Infrasture-As-Code is a principal I strongly believe in when implemented correctly, and I aim to do this with my work for demonstration and learning purposes. For this reason, i'm running this blog as a DO App (for reasons described above). We'll have immutable infrastructure by defining my app as a container, and will have a good control over the app and it's associated configurations by defining them in terraform. While i'm currently using DO Apps for hosting/deploying the blog, I will consider updating this for use on other platforms and/or services (e.g. EKS, Fargate, local k8s) in the future, and packaging this server as a container should make this an easier proposition in the future.

## Why Terraform?

Terraform is reasonably ubiquitous and agnostic to different infrastructure platforms. Luckily, digital ocean has a good terraform provider that I can use for publishing this, but when i expect to deploy this application on other platforms, I have faith that the terraform community is generally supporting some of the most common/popular platforms. The other primary IaC options out there seem to be CloudFormation (aws-only), Crossplane (Kubernetes-only), and Pulumi. While these other solutions are interesting and certainly worth exploration at a future date, I'm planning to use terraform for the time being given it's wide community support and platform agnosticism. This also gives me a good basis for defining other pieces of the infrastructure that may be needed for hosting the blog such as DNS records, load balancers, or other services in the future. I'll plan to define some terraform modules for these different deployment scenarios and leverage terraform cloud as the backend for the terraform state & locking.

Further reading:
- Crossplane vs Terraform vs Cloudformation vs Pulumi

# Alltogether now

In summary, I've created a DO app that is deployed anytime the main branch of my repo is updated. While my blog's repo is public, I've limited write access to myself. Since my app is hosted on Github with a Dockerfile in the root directory, Digital Ocean detects this and ultimately uses the dockerfile for creating my application. You may run into some CORS issues when attempting to do this, depending on your hugo configuration. In my repo, i've created a basic make target for running the dev server for validation purposes, so that you can
