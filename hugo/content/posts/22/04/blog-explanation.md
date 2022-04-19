---
title: "Creating a blog for fun and profit"
date: 2022-04-18
type: "posts"
description: "Adding my first blog post describing my blog"
summary: "You either die a hero or live long enough to see yourself become the villain"
tags: ["first", "blog", "posts" ]
---

# Hello, World!

Hello! I’m [smerc](https://twitter.com/smercDev), an engineer with experience across a few different "areas" of software development. I’m always looking to try out new technologies and ways to grow personally & professionally. To that end, i’ve started this blog to document my progression, explain concepts, and improve my presentation & writing skills. Readers can expect a number of different topics from software development, cloud infrastructure, career insights, gaming, and other hobbies. Over time, i’ll likely narrow this down as I find an audience, but initially topics may be a bit varied.

{{< lead >}}
You either die a hero or live long enough to see yourself become the villain
{{< /lead >}}

{{< youtube id="8WfRcnF4iZI" >}}

Starting a blog is a weird & awkward thing for me. For years, I’ve laughed at _most_ (not all) people that have a tech blog. I used to view “tech bloggers” as people shilling the latest corporate IT jargon and marketing bullshit. In retrospect, it’s a bit judgemental to look at the writings over others and draw such a reductive conclusion, so I figured I’d give it a try myself. The goal here is to improve my overall understanding of different technologies and work on become a better communicator around those topics as well, starting with writing. Hopefully I can add in some clever memes along the way.

# Ogrengineered blog

This blog is intended to be a easy-to-deploy service that I can run in a number of different places as needed. While initially, I'm currently running this blog as a container on [DigitalOcean App Platform](https://docs.digitalocean.com/products/app-platform/) for simplicity reasons, I aim to run this blog on different platforms (which is why this is run as a container rather than a static site even though it costs 5$/month) over time as my requirements change and I explore new technologies & platforms. Currently, this is created using Hugo as my static site generator and the digital ocean app is created/managed using Terraform. This is all guarded by some github actions to validate hugo works as expected, and that terraform output is within expectations. I’ll dig into more details around these individually below. For the purposes of brevity, this blog is intended to be more of an overview and explanation rather than a how-to for setting up your own blog (though the [source code is available](https://github.com/smerck/blog)).

## The first attempt

![k8s logo](/kubernetes-logo.png)

In my first ogrengineering this blog, I was focused on running this blog from a kubernetes cluster as an excuse to get more familiar with kubernetes. While that’s a noble goal, using a managed kubernetes cluster ultimately proved too expensive for this purpose. While I could reasonably run a kubernetes cluster at home, I think that’s more effort than I really want to put in for the purposes of hosting a blog (I firmly believe friends don’t let friends manage kubernetes). While I fully intend to do more work focused around kubernetes, this blog has no requirement for a kubernetes cluster when a much simpler solution will work fine for this use-case.

## "But there are easier ways!"

I do not deny this! I'm sure there are much easier, faster, and simpler ways to achieve the goal of writing a blog, but I had some specific goals in mind:

1) Create an easily deployed stateless applications that I can use for various purposes at a later date.
2) Exercise a bit more control over the application for learning purposes (controlling dns, various application details, networking, etc)
3) Maitain all my blogs/updates in source code & update with a GitOps/Infrastructure-As-Code approach to improve my perspective on these workflows.
4) Write a blog.

That being said, this will likely take many forms over time and is intended to just serve as a starting point for later work.

# Source code

[github.com/smerck/blog](https://github.com/smerck/blog) has all of the configuration for this blog, and i’ll point you to a few distinct part of the configuration of interest. I’ve set up main as a protected branch requiring me to open a pull request rather than pushing directly to the main branch. While this is “unnecessary” for me working on a solo project, I consider this to be good practice and it allows me to trigger some github actions for a branch on github before the pull request merges. I’ve added the associated configurations necessary for a public project on github:

* [Branch protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/managing-a-branch-protection-rule?source=post_page---------------------------) on main requiring PR, require passing status checks, require approval from me as a codeowner.
* Github actions only trigger from branches I create currently. Again, this is totally expected in my solo project, but I wanted to specifically avoid having someone open a PR and trying to execute anything unexpected from a CI context, since CI may privileged/api access to certain tools. This is probably significant paranoia on my part for a _blog_, but it seemed valid.
* Require Squash merging: I think it just makes it easier to understand exactly where changes are introduced and makes a less noisy main commit log.

Additionally, by putting some of these restrictions in place, i can prevent myself from doing dumb things that i’ll regret later and overall is a signficant improvement on the quality of the main commit log. Witness my atrocities (aka, my main branch):

![oopsie](/oops-small.png)

This is what I get for trying to iterate on docker builds by pushing all my commits to main to trigger digital ocean rebuilding my app. I've since improved this drastically and stopped being lazy about this. This sort of thing would typically drive me nuts, but I had a higher tolerance for poor hygeiene of a personal project. No longer!

## Hugo

![The hugo logo](/hugo-logo.png)

Hugo (https://gohugo.io/) is a static site generator that takes simple markdown files and uses templates to convert these into functional web pages. You can build templates for different pages and additional functionality. There’s a wide range of themes available that can be customized to fit your needs. In this case, I've selected the [congo](https://github.com/jpanther/congo) and [configured it for my needs. It’s not much more complicated than that! You can see all my configurations in the source code repository, along with the markdown for this blog post. I’ll likely extend this at some point in the future, but for now, I'm very satisfied with a minimal configuration.

## Managing cloud resources with terraform

![Terraform logo](/tf-logo.svg)

Although this is a very simple application, to create the digital ocean app or update its configuration, i’ve chosen to use digital ocean apps for this purpose. This has some additional niceties in that it configures the DNS records needed for the blog to function. I’ve also added the DNS records that are necessary for sending & receiving email from a customer domain account. I currently use google domains as my DNS registrar, but use Digital ocean for managing my DNS records. Currently, I use a terraform cloud backend for my terraform state.

## DNS

Google domains provides a lot of this functionality out of the box, but I’ve chosen to do this with digital ocean for the purposes of furthering my understanding of configuring & managing DNS. I’ll likely end up using a different DNS service at some point down the road, but i’m doing two things for DNS management:

* Digital Ocean App Platform [will configure DNS for your applications](https://docs.digitalocean.com/products/app-platform/how-to/manage-domains/) assuming the domain registrar is pointing to the correct nameservers. For the purposes of this blog, this is adequate for my needs.
* I’ve added some additional [DNS records](https://github.com/smerck/blog/blob/main/infra/tf/dns.tf#L10-L57) with terraform to enable the smerc.dev domain email addresses.

Google domains provides this out of the box, but this is **The Ogrengineered blog** for a reason.

## CI/CD

Currently, Digital Ocean App Platform will track my main branch for my blog repo and automatically deploy a new app based on the updated contents of the repo.

For CI, I’ve added a few basic checks that do things like terraform validation & formatting, and executing hugo to generate blog posts as github actions.

* Hugo will attempt to build the blog contents with [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo).
* Validate, fmt, tf plan & copy output into PR with [setup-terraform](https://github.com/hashicorp/setup-terraform) actions.

When all github actions execute and complete successfully, the pull request can be merged.

* If a terraform change is merged, a terraform apply will be executed.
* Digital Ocean watches main for changes and deploys and update if needed.

# Upcoming

I’m currently doing a lot of work focused around kubernetes & software development, so I intend to write about those exploits there. There are also some topics that I have a perspective on after having worked in the tech industry for 10+ years across multiple “verticals” (e.g. networking, private & public cloud infrastructure, SRE/reliability, developer advocacy, software development, DevOps). While there’s a fair amount of overlap between these (sometimes poorly defined) topics, I’ll dive more into these topics in future blog posts. If you have an interest in hearing from me on a particular topic, let me know (link to twitter)!

* Kubernetes, cncf, etc
* Envoy, service meshes, l4/l7 proxying
* Observability
* DNS management
* Local development with kubernetes, tilt, etc
* Career thoughts after 10+ years // 10 things I wish I knew when I started
