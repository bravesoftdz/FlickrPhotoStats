FlickrPhotoStats
================

Flickr Photo stats provides the ability to request information from your Flickr pool using the Web REST API.

**License:** GNU General Public License.

The app only needs a valid *API Key* that can be requested in the App Garden where my application is already [published](https://www.flickr.com/services/apps/72157639602915254/):

[The App Garden - API request](https://www.flickr.com/services/apps/create/apply/?).

Once obtained, you can load your list or start a new one using the Api Key.

Example of the app:

Dashboard:
![](http://3.bp.blogspot.com/-Wuf66X97Lac/VYh1ezan0tI/AAAAAAAAE58/lr1ECQ4Bjpc/s640/dashboard.png)

Processing:
![](http://4.bp.blogspot.com/-CEV0jQ6qLfc/VYh55Oj3_rI/AAAAAAAAE6Q/3lpyMGmQS00/s640/dashboard2.png)

Authentication:
![](http://1.bp.blogspot.com/-qqAYuDjdP6w/VYiAROWt6NI/AAAAAAAAE64/HtLd_lIz26Q/s640/auth.png)

It will keep a list of all the photos you add to keep track of them automatically.
The following information will be saved:
- Number of views.
- Number of Likes.
- Number of Comments.
- Last time it was updated.
- Affection (number of likes over number of views).

Each value is saved and stored over time so the tool can display the trend of a particular photo.

Code convention:
- > 1000 < 3000 views: blue.
- > 3000 < 5000 views: green.
- > 5000 < 8000 views: Olive.
- > 8000 < 10000 views: Fuchsia. 
- > 10000 views: red.
 
Use **Batch Update** to easily update all the values and keep a good track record of your flickr pool.

Latest version of the binary can be found here (stable):

- FlickrPhotoStats(x86) v3.0. (https://app.box.com/s/v3xdczujjdm1b85kcs8k)
- FlickrPhotoStats(x64) v3.0. (https://app.box.com/s/1i67o9g6krr0398kprk1)

New versions of the application (RC):

- FlickrPhotoStats(x86) v3.1. (https://app.box.com/s/djm6lei8rli3pkfa1fy3)
- FlickrPhotoStats(x64) v3.1. (https://app.box.com/s/w24hr4cq8nkh9c22z4iw)

New versions of the application (beta):

- FlickrPhotoStats(x86) v4.1. (https://app.box.com/s/ydtsu1ceq3f5dkkilct20qhnkdahcddd)
- FlickrPhotoStats(x64) v4.1. (https://app.box.com/s/x3ta5x4z3o6e5h7ozc82d6e49uslzjw5)

Latest release candidate can be found here:

- FlickrPhotoStats(x86) v4.3. (https://app.box.com/s/3ftq5jts9srydqzwpj02adml1gkav435)
- FlickrPhotoStats(x64) v4.3. (https://app.box.com/s/3ftq5jts9srydqzwpj02adml1gkav435)

## Changelog
### Features for version 3.1:
- Get the total list of photos using flickr.people.getPhotos for automatic population of the application.

### Features for version 4.1:
- OAuth authentication.
- Get list of groups and create your own profiles for automatic population.
- Totals for Albums.

### Features for version 4.3:
- Dashboard.
- Trend lines.
- Album population.

Source code is available here.

The application can now use **OAuth** authentication using REST. The application itself can validate the user tokens and provide all the flow within the application. I will write a post about this in my blog.

Developed with Delphi XE6.

## Sponsors
No sponsors yet! Will you be the first?

[![PayPayl donate button](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=L5FCF6LX5C9AW "Donate once-off to this project using Paypal")
