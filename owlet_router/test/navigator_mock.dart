/*
 Created by Thanh Son on 15/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<MockNavigatorObserver>()])
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
