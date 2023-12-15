# Owlet Router Example

[![version](https://img.shields.io/pub/v/owlet_router)](https://pub.dev/packages/owlet_router) [![like](https://img.shields.io/pub/likes/owlet_router)](https://pub.dev/packages/owlet_router) [![issues](https://img.shields.io/github/issues/sonnts996/owlet-router)](https://github.com/sonnts996/owlet-router) [![license](https://img.shields.io/github/license/sonnts996/owlet-router)](https://github.com/sonnts996/owlet-router)

The [owlet_router](https://github.com/sonnts996/owlet-router/tree/refactor/owlet_router) is a route
manager. It utilizes the route builder to
construct the router.

It is designed with several purposes in mind:

- Providing a clear and easily definable route manager that is simple to read and use.
- Built upon the base Flutter Router, allowing for integration with various page route types and the
  ability to customize and extend the router.
- Enabling modularization of the router, making it easy to segment routes and create independent
  routes.
- Offering the capability to check, prevent, or redirect routes before they are pushed.

# Project structure

```
// Main NavigationService	
MainRoute 					 
  │ // home page with a nested navigator
  ├── home ('/home') 		 
  │ │
  │ │ // nested route is '/home/'
  │ ├── homePage ('/') 		
  │ │
  │ │ // nested route is '/home/t/* 
  │ └── tabPage ('/t/*') 
  │ 
  ├── profile ('/profile')
  └── splash ('/')
```

This example app showcases a "MainRoute" module with three pages: Home, Profile, and a Splash Page.
The Home page leverages a nested service, commonly used for nested navigation. When you navigate to
a route starting with "/home", the app checks if the Home page is already open. If not, it opens it.
Otherwise, it sends a notification to the open Home page, prompting it to update its "TabPage" and
scroll to the relevant content. This demonstrates dynamic page updates based on routing actions,
avoiding unnecessary page creation.

> [!Heads up!]
>
> The Owlet Router details within this example app might be a bit out-of-date. It's always a good
> idea to refer to the latest
> official [documentation](https://github.com/sonnts996/owlet-router/tree/main/owlet_router) for the
> most accurate information.