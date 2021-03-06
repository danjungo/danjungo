<style type='text/css'>
<!-- 
.txt{font-size:11pt}
-->
</style>
<h5>
About
</h5>
<div class='txt'>
<br />
<br />
<img alt='Dan_Bikle' height='300' id='DanBikle' src='http://bornboulder77.googlepages.com/DanBikle2006_09_7.jpg' width='400' />
<br />
<br />
In June of 1988 Dan Bikle graduated from Caltech with a BSEE.
<br />
<br />
<br />
<br />
A year before that he had started working at Oracle Corporation as an engineer.
<br />
<br />
A year after graduation, he left Oracle and started a consulting
business to help early adopter customers implement ERP systems based
on both Oracle Financials and Oracle Manufacturing which were both new
and immature products.  It was a perfect time to start that consulting
business.
<br />
<br />
During the 1990s Dan worked at a wide variety of clients in the Bay
Area who needed help migrating off of legacy systems (such as ManMan)
to Oracle Applications.
<br />
<br />
In 1998 Dan started taking on clients who were building large
database backed websites such as Lycos' MailCity.
<br />
<br />
The web started to dominate Dan's consulting business.  In 2001 he
finished his last Oracle Applications engagement and focused on
database backed websites.
<br />
<br />
In 2003 Dan took on a full time job in the Sun IForce lab to connect
with engineers and early adopter customers who wanted to use low-cost
hardware to build clustered Oracle databases to back large websites.
The timing was good.  Oracle Corporation delivered cache-fusion in
Oracle 9i (and enhanced in 10g) which made horizontal scalability
possible in the database tier of an application.
<br />
<br />
Another big event
was delivery of the low-cost 64 bit Opteron CPU from AMD.  Clustered
databases powered by low cost Opteron systems offered serious
competition to expensive, vertically scaled machines from Sun, IBM,
and HP.  In 2005 Dan left Sun to take advantage of that opportunity.
<br />
<br />
Also in 2005, a large change was delivered to the world of
web application development: Ruby on Rails (RoR).
<br />
<br />
Before RoR, Java based systems were the only good option available
to an implementor of a large database backed website.
<br />
<br />
RoR hits the sweet spot of the constraint-configurabilty-tradeoff.
<br />
<br />
Between 2005 and 2008 Dan spent much of his time leveraging the
advantages offered by lowcost hardware and RoR to build an online
trading platform.
<br />
<br />
In early 2009 Dan was drawn into the world of Mobile Application Development.
<br />
<br />
By April 2009 Dan had learned the Rhomobile Open Framework and used it to prototype iPhone Apps.
<br />
<br />
On June 12 2009 Dan released the iPhone App: RowSeeUs which connects an iPhone to
<a href='http://www.google.com/search?q=Oracle+CRM+On+Demand' target='a'>Oracle CRM On Demand.</a>
<br />
<br />
The companion site is:
<a href='http://RowSee.us' target='a'>
http://RowSee.us
</a>
<br />
<br />
RowSeeUs App Store link:
<br />
<br />
<a href='http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=319913143&amp;mt=8' target='a'>
<img height='57' src='/images/rsu57by57_rounded.png' width='57' />
</a>
<br />
<br />
On July 21 2009 Dan released the iPhone App: Map611 which is a simple
map storing app.  The companion site is
<a href='http://Map611.com' target='a'>
http://Map611.com
</a>
which also
serves the Map611 Web App under the URL:
<a href='http://Map611.com/iPhone' target='a'>
http://Map611.com/iPhone
</a>
<br />
<br />
Map611 App Store link:
<br />
<br />
<a href='http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=324667135&amp;mt=8' target='as'>
<img height='57' src='/images/squarem611_57_rounded.png' width='57' />
</a>
<br />
<br />
Map611 Web App:
<br />
<a href='http://Map611.com/iPhone' target='a'>
<img src='/images/squarem611_57_webapp.png' />
</a>
<br />
<br />
In August of 2009 Dan saw the Vic Gundotra youtube video about HTML5 in the Gmail iPhone app.
<br />
<br />
So, Dan then learned how to use HTML5 to deliver features which compete with native apps:
<ul>
<li>Offline capability</li>
<li>Ability to store data in the phone</li>
</ul>
<br />
Another feature of HTML5 is portability.  An app written in HTML5 will run on any phone which supports HTML5.
<br />
<br />
HTML5 is supported by Android 2.0 and Opera10 (targeted at Windows Mobile).
<br />
<br />
In late August 2009 RIM acquired Torch Mobile.  It is obvious to Dan that eventually HTML5 apps will run on RIM BlackBerry phones.
<br />
<br />
Dan delivered his first HTML5 iPhone web app on September 3, 2009:
<br />
<a href='http://iWantCRM.info' target='as'>
<img height='57' src='/images/iwWebClipIcon.png' width='57' />
</a>
<br />
<br />
Even for building mobile applications,
Dan's methodology has a strong "server" focus.
<br />
<br />
When Dan builds the server, he follows this approach:
<br />
<br />
0. Obtain / Derive a list of functions the site or App will deliver
<br />
<br />
1. Author security policies for the site
<br />
<br />
2. Obtain / Derive a list of Model classes for the application
(Typically these are nouns which jump out from function descriptions)
<br />
<br />
3. Decide how the Model classes are related
(One-Many, Many-Many, One-One)
<br />
<br />
4. Look for Data Structures in Models (Tree, Nested Set, List)
<br />
<br />
5. Code up the model classes
<br />
<br />
6. Constrain the site to our security policies
<br />
<br />
7. Code up the physical database structure and then run that code
<br />
<br />
8. Fill up the database with fixture data so the developer can "see" it
<br />
<br />
9. Build a web1.0 prototype which looks something like Craigslist
(Also you could get a jump-start on step 12 here)
<br />
<br />
10. Iterate with the users over the prototype
<br />
<br />
11. Audit site for compliance to our security policies
<br />
<br />
12. Drape a pretty skin over the prototype and stop calling it a prototype
<br />
<br />
13. Iterate with the users over the site
<br />
<br />
14. Code up testing/auditing framework for the application
<br />
<br />
15. Leverage off the testing code to setup monitoring
<br />
<br />
16. Swap out the development database with a clustered database infrastructure
<br />
<br />
17. Deploy the server code to a production infrastructure
<br />
<br />
18. Turn on monitoring, production level backups, and disaster recovery mechanisms
<br />
<br />
19. Run all the tests written in step 12
<br />
<br />
20. Fix bottlenecks found by load tests
<br />
<br />
21. Test disaster recovery
<br />
<br />
22. Start Customer Support application
<br />
<br />
23. Go Live!
<br />
<br />
24. Vigilantly monitor the site
<br />
<br />
25. Frequently scan Customer Support application for indications of problems
</div>
