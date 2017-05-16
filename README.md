# Table of Contents

- [Introduction](#introduction)
- [Architecture](#architecture)


<h1 id='introduction'>Introduction</h1>

The [Social Media Explorer](http://social-ui.au-syd.mybluemix.net) app is a
Proof of Concept (POC) showing how
[IBM Bluemix](https://www.ibm.com/cloud-computing/bluemix/what-is-bluemix) and
[Watson](https://www.ibm.com/analytics/watson-analytics/us-en/) can be used for social media analytics.
It demonstrates how the Bluemix ecosystem seemlessly integrates
with best of breed technologies to deliver a **birds-eye-view** snapshot of the social media sentiment
and to allow for **drill-down** exploration and analysis.

<img src="https://github.com/nikolay-g/social-media-app-doc/raw/master/img/DemoScreencast.gif" width="550">


<h1 id='architecture'>Architecture</h1>

The following diagram shows a bird view of the architecture:

![Alt text](/img/BigPicture.jpg?raw=true "Architectural Overview")

Social media data is ingested via [Synthesio](http://www.synthesio.com/).
We use Twitter, but Synthesio can easily incorporate various other sources like Facebook as well.
If customer data is needed, we can also feed it via other on-premises systems like
[Neteeza](https://www-01.ibm.com/software/data/netezza/).

Social media and customer data is fed into a [Node-RED](https://nodered.org/) workflow, which
is hosted on Bluemix. It cleans, normalises, and alayses the data. Node-RED allows for
data processing with minimum or no coding. It is suitable for quick evaluation of new ideas
and prototyping. Node-RED integrates well with many Watson services. In this app, we use
the Watson services for tone, sentiment, and keyword extraction and analysis. Once the ingested
data is processed, the Node-RED flow stores it in a Cloudant database.

A [Node.JS](https://nodejs.org/en/)/[Express](https://expressjs.com/)
microservice exposes the Cloudant database as an API. It acts as a
[Backend For Frontend (BFF)](http://samnewman.io/patterns/architectural/bff/)
because the provided API is designed to be consumed by a UI component.

The web user interface is served from another web server. The UI is
developed in [React](https://facebook.github.io/react/) and [Redux](http://redux.js.org/)
which is "compiled" to static web content. Once downloaded by the client, the
app makes direct calls to the Node.JS BFF service to retrieve analysed data.

The BFF service and the UI web server are developed as [Cloud Foundry](https://www.cloudfoundry.org/)
apps on Bluemix. As such, they can easily scale by adjusting the number of instances
"behind" their [routes](https://docs.cloudfoundry.org/devguide/deploy-apps/routes-domains.html).
Their source code can be found here:
 - [BFF Service](https://github.com/CarlyLB/social-media-nodejs)
 - [Web UI](https://github.com/CarlyLB/social-media-react-redux)
