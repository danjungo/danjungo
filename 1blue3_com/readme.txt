http://1blue3.com is a site which demonstrates how to copy data from Oracle Enterprise Manager to an HTML5 web app destined for an iPhone.

I have not looked at this site for 18 months but,
it appears the site is still up.

The main idea is that I'd have Firefox running in a virtual frame buffer on the host running Oracle Enterprise Manager.

Every 10 minutes I'd scrape HTML out of firefox and send it through the firewall to the rails site.

I'd use a simple daemon written in Ruby to transform the HTML into something suitable for the Rails templates.

Then an iPhone would connect to 1blue3.com and see data from Oracle Enterprise Manager.

Since the iPhone browser can use some HTML5 features, I configure the HTML so the iPhone can access it while the iPhone is disconnected from the web.

I thought up this demo after I saw that gmail is an HTML5 app which allows me to store e-mails inside my browser and read them while disconnected.
