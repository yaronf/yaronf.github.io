---
layout: post
title:  "Identity Pinning: A New Approach to Certificate Validation"
date:   2019-10-31 11:00:18 +0300
categories: ietf
---
## Just Published: RFC 8672 on Server Identity Pinning  -- a modern, lightweight alternative to certificate pinning

The RFC Editor just published [RFC 8672](https://www.rfc-editor.org/rfc/rfc8672.html), a specification that can potentially make TLS deployments much more secure by virtually eliminating the risk of forged public-key certificates.

For many years we have been seeing [attacks](https://threatpost.com/final-report-diginotar-hack-shows-total-compromise-ca-servers-103112/77170/) on certificate authorities (CAs). All CAs are essentially created equal, and if a rogue CA issues a certificate for *example.com* and hands it to a malicious server, there's nothing to stop clients from connecting to the server and trusting its identity. The same is true for servers located behind enterprise firewalls. A rogue CA could just as well issue a fake certificate for *finance-dept.example.com*, regardless of whether it can access the server or not.

An often used approach within enterprise networks is *certificate pinning*. Normally we trust a server certificate because it is the last component of a certificate chain: a chain that starts with CAs that are widely known, and are configured into the TLS client (the browser, typically), contains one or two lesser "intermediate" CAs, and ends with the server certificate. Each of these chained certificates is digitally signed by the one above it.

![pins-1358849_800.jpg](/assets/pinning-pins.jpg)
*Photo: Brett Hondow, Pixabay*

Certificate pinning, the solution that we are replacing, forgoes the certificate chain in favor of direct trust in the server's certificate, which is stored in the client's certificate store. Unfortunately, certificate pinning is a management nightmare: every time the server's certificate is reissued -- typically once a year -- all clients need to be updated with the new certificate. A variant of this approach is to pin the CA, instead of the server certificate, by having all clients remember that the certificate for *example.com* must only be issued by *my-favorite-ca.com*. This works quite well… until the company decides to migrate to *cheaper-ca.com*. Then, all clients need to be updated with the new CA, a major pain. For this reason and others, [internet standards](https://tools.ietf.org/html/rfc7469) for certificate pinning [have not seen](https://blog.qualys.com/ssllabs/2016/09/06/is-http-public-key-pinning-dead) wide deployment.

In an attempt to simplify this solution, we came up with the identity pinning notion, based on the [Trust-on-First-Use (TOFU)](https://en.wikipedia.org/wiki/Trust_on_first_use) principle:

The first time a client connects to a server, they both compute a secret value based on the TLS handshake. The server sends back to the client an opaque (encrypted) ticket that contains this secret. The client that already computed the secret independently, stores the ticket along with the secret for future use. Note the trust-on-first-use element here: the server authenticates itself the good old fashioned way, using only its certificate.

![Pinning_ Initial Connection.png](/assets/pinning-seq1.png)
*Initial Connection*

On any subsequent connection, the client sends the ticket to the server. Only the genuine server is able to decrypt the ticket, obtain the secret and send back a proof that indeed, it knows the secret. The client now verifies the proof. If the proof is correct, the TLS handshake completes successfully and the connection is established. Otherwise, *poof*  --  the TLS handshake is aborted.
![Pinning_ Subsequent Connection.png](/assets/pinning-seq2.png)
*Subsequent Connection (Simplified)*

What we have gained is *second-factor authentication for the server*. The TLS server not only needs to present a valid certificate, as usual, it also needs to prove that it possesses the secret that's needed to decrypt the ticket, proving its legitimacy.

This all happens automatically with no need to configure anything, either on the client or the server side. It is also independent of the server's certificate (hence *identity pinning*), which eliminates the complexity inherent in certificate pinning solutions. 

You may want to [read the RFC](https://www.rfc-editor.org/rfc/rfc8672.html) for the lowdown on this protocol. We learned from other people's experience, and the protocol has quite a few **features** that make it attractive for real-life use:

* **Generality**: identity pinning works at the TLS level, with no dependence on HTTP or assumptions on traffic. It can be applied to web traffic on the internet and within the enterprise, to REST APIs, and to non-HTTP protocols. 
* **Zero management**: nothing needs to be configured on the client side. On the server side there is only one simple parameter: the ticket lifetime (normally between 7 and 31 days).
* **Robustness**: the protocol is not effected by certificate renewal, CA change or even certificate revocation, and can accommodate single servers and server clusters alike.
* **Very low overhead**: the ticket and additional TLS messages are very small. The client maintains a "pin store" that holds a few dozen bytes for each server it has seen in the last month.
* **Up to date**: the protocol is defined for TLS 1.3 which, in late 2019, is quite new but already widely deployed.

![tls13.png](/assets/pinning-tls13.png)

* **Privacy**: servers are required to regenerate a new ticket on each connection, so that tickets cannot be used by an eavesdropper to link different sessions by the same client.
* **Deployment flexibility**: the protocol includes a "ramp down" mode, in case a server owner decides to disable the use of this mechanism.
* **Best fit to enterprise networks**: whereas servers on the open internet can benefit from [Certificate Transparency](https://www.certificate-transparency.org/), servers located "behind the firewall" typically do not have their certificates stored in the CT infrastructure. Identity Pinning is a simple way to harden such servers' secure connectivity.

We have [implemented](https://github.com/yaronf/mint) the Identity Pinning protocol but due to the slow pace of standardization, the implementation is somewhat outdated by now. If you plan to implement the protocol, feel free to reach out to [the authors (Daniel Migault and myself)](mailto:draft-sheffer-tls-pinning-ticket@ietf.org) with any questions.
