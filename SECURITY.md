# go-git Security Policy

The purpose of this security policy is to outline `go-git`'s process
for reporting, handling and disclosing security sensitive information.

## Supported Versions

Only the latest major release is supported, and within it only the latest
minor release. Security fixes are released as patches on top of that minor
release. Users are encouraged to upgrade to the latest minor/patch release to
benefit from the most up-to-date features, bug fixes, and security
enhancements.

Once the final release of a new major version is published, the previous major
version is no longer supported. Users may backport fixes to older versions
themselves, but maintainer support for doing so is best effort only.

The supported versions policy applies to both the `go-git` library and its
associated repositories within the `go-git` org.

## Scope

This policy covers the code in the repositories of the `go-git` org. `go-git`
is commonly used to operate on repositories, remotes and servers that are not
trusted, so the following are treated as untrusted input: repository contents
(objects, packfiles, index, configuration and refs obtained from a remote),
data received over any transport, and responses from remote servers.

### In Scope

Examples of issues considered security vulnerabilities include:

- Cloning, fetching, checking out or otherwise operating on an untrusted
  repository resulting in files being read or written outside the intended
  worktree, or in unexpected modification of repository metadata, for example
  via path traversal or symlinks.
- Bypass of authentication, host key verification or TLS certificate
  validation in the provided transports.
- Credentials being leaked, for example via logs, error messages or by being
  sent to a different host than intended.
- Untrusted input causing a panic, or resource consumption (memory, CPU, disk)
  disproportionate to the size of the input.
- Bypass of security controls that `go-git` does implement, including those
  used when serving repositories.

### Out of Scope

The following are generally not considered security vulnerabilities:

- Issues that require an attacker to already control the local repository,
  its configuration, or the filesystem it lives on. This does not apply to
  content obtained from an untrusted source, including content made local by
  an earlier clone or fetch.
- Missing server-side features or security controls available in upstream
  Git. See [Server-side Security Considerations](#server-side-security-considerations).
- Vulnerabilities in dependencies that are not reachable through `go-git`.
  Please report those to the affected project.
- Issues in example code, tests and development tooling. This does not apply
  to GitHub Actions workflows that could expose secrets or allow untrusted
  contributions to compromise a repository.
- Issues that only affect unsupported versions.

### Server-side Security Considerations

`go-git` is a Git implementation library, not a complete Git server. While it
provides the building blocks for implementing Git servers, it does not
currently support all the features, security controls, and configuration
options available in upstream Git (`git-upload-pack` and `git-receive-pack`).

Applications using `go-git` to expose Git repositories to untrusted clients
must implement and enforce the security controls appropriate to their
deployment. These may include authentication, authorisation, reference access
restrictions, object reachability checks, push policies, resource limits, and
repository isolation.

`go-git` should not be assumed to provide the same server-side security
guarantees or configuration defaults as upstream Git. Building a
production-grade Git server requires additional integration work and security
assessment.

We welcome reports of missing security-relevant capabilities and encourage
contributors to help improve server-side parity with upstream Git. However,
missing server-side features are not automatically considered security
vulnerabilities. The known gaps are tracked publicly in
[go-git/go-git#2614](https://github.com/go-git/go-git/issues/2614), where
missing capabilities should be raised. If you are unsure whether a gap is
exploitable, report it privately as described below.

Security issues in functionality implemented by `go-git`, including
vulnerabilities that allow security boundaries to be bypassed or untrusted
input to cause unintended behaviour, remain within the scope of this security
policy and will be assessed individually.

## Reporting Security Issues

Please report security vulnerabilities privately using GitHub's private
vulnerability reporting on the `go-git/go-git` repository at
https://github.com/go-git/go-git/security/advisories/new. This applies to all
repositories in the `go-git` org, so please name the affected repository in
the report. Alternatively, reports can be sent to
go-git-security@googlegroups.com. Do not publicly disclose the details of the
vulnerability until a fix has been implemented and released.

Before reporting, please confirm the issue reproduces against the latest
commit on the default branch of the affected repository. Reports must include:

- A proof of concept that demonstrates the issue, such as a test case, a
  program or a crafted repository.
- Steps to reproduce, including the commit tested and the Go version and
  operating system used.
- The impact, and any mitigations if known.

Unvalidated scanner or tool output is not a proof of concept. Reports that do
not meet these requirements may be closed without further investigation.

The project maintainers will acknowledge the receipt of the report and work with
the reporter to validate and address the issue.

Please note that `go-git` does not have any bounty programs, and therefore does
not provide financial compensation for disclosures.

## Security Disclosure Process

The project maintainers will make every effort to promptly address security
issues.

Confirmed vulnerabilities are assigned a GitHub Security Advisory (GHSA)
identifier. Once a fix is released, the advisory is published to notify users
and provide appropriate mitigation measures. Reporters are credited in the
advisory unless they ask to remain anonymous.

While all reports are received through `go-git/go-git`, each repository in
the `go-git` org publishes its own advisories in its Security tab. For
example, `go-git` advisories can be found at
https://github.com/go-git/go-git/security/advisories.
