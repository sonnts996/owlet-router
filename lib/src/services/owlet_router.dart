/*
 Created by Thanh Son on 27/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
library router_service;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:objectx/objectx.dart';

import '../advance/owlet_navigator.dart';
import '../base/navigation_service.dart';
import '../base/route_finder_delegate.dart';
import '../base/route_history.dart';
import '../base/route_mixin.dart';
import '../route/finder/default_router_finder.dart';
import '../route/route_base.dart';
import 'default_value.dart';

part 'navigation_service_impl.dart';
part 'owlet_delegate.dart';
part 'owlet_information_parser.dart';
part 'route_history_implement.dart';
