---
layout: post
title:  "HTTP Message Signatures in Go, by the Book"
date:   2024-06-23 11:00:18 +0300
categories: ietf "HTTP message signatures"
---
There are many good reasons to sign HTTP messages, to ensure authenticity and integrity of HTTP service calls (a.k.a. REST APIs). Now that [RFC 9421](https://datatracker.ietf.org/doc/html/rfc9421) is finally published, we can expect many people to migrate from [provisional](https://datatracker.ietf.org/doc/html/draft-cavage-http-signatures-12) and [proprietary](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) solutions into the standard.

My [Go (Golang) implementation](https://github.com/yaronf/httpsign) covers nearly the entire RFC, and has been tested with all the test vectors that are sprinkled all across the standard. The package is also reasonably [well documented](https://pkg.go.dev/github.com/yaronf/httpsign), with a number of examples included. It is early days for the standard - and for the Go package - so let me know if you find the library useful. And definitely let me know if something is not working right!

There's a large community of people working now on [service-to-service authentication](https://datatracker.ietf.org/wg/wimse/about/), which just happens to be a natural use of HTTP Message Signatures. I hope my package is put to good use in securing service infrastructure.
