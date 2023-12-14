/*
 Created by Thanh Son on 13/11/2023.
 Copyright (c) 2023 . All rights reserved.
*/
import 'package:objectx/objectx.dart';

int rowLength = 2;

TreeNode generate(int depth, int index) {
  if (depth == 0) {
    return TreeNode('/$depth-$index');
  } else {
    final children = <TreeNode>[];
    for (var i = 0; i < rowLength; i++) {
      children.add(generate(depth - 1, i));
    }
    return TreeNode('/$depth-$index', children: children);
  }
}

class TreeNode {
  TreeNode(this.value, {this.children = const []}) {
    children.forEach(apply);
  }

  final String value;

  Iterable<TreeNode> find(String value) {
    if (path == value) return [this];
    return children.fold(
      [],
      (previousValue, element) => [...previousValue, ...element.find(value)],
    );
  }

  String get path {
    if (parent == null) return value;
    return '${parent!.path}$value';
  }

  final List<TreeNode> children;
  TreeNode? parent;

  void apply(TreeNode element) {
    element.parent = this;
  }

  String get spacing {
    if (parent == null) return '';
    return '${parent!.spacing}\t';
  }

  @override
  String toString() {
    final String str;
    if (parent == null) {
      str = '$spacing─── $value\n';
    } else {
      str = '$spacing└── $value\n';
    }
    final buffer = StringBuffer(str);
    children.forEach(buffer.write);

    return buffer.toString();
  }
}

void main() {
  final tree = generate(10, 1);
  const value = '/10-1/9-1/8-1/7-1/6-1/5-1/4-1/3-1/2-1/1-0/0-1';
  find('recursive', () => find1(tree, value));
  find('BFS', () => find2(tree, value));
  find('DFS', () => find3(tree, value));
  find('a-search*', () => find4(tree, value));
  find('child-search', () => tree.find(value).firstOrNull);
}

void find(String name, TreeNode? Function() finder) {
  final start = DateTime.now();
  final node = finder();
  final end = DateTime.now();
  '${end.microsecondsSinceEpoch - start.microsecondsSinceEpoch}: ${node?.path}'.print(tag: '$name run in microseconds');
}

TreeNode? find1(TreeNode node, String value) {
  if (node.path == value) {
    return node;
  } else {
    for (final e in node.children) {
      final result = find1(e, value);
      if (result != null) return result;
    }
  }
  return null;
}

TreeNode? find2(TreeNode root, String value) {
  final queue = <TreeNode>[root];
  while (queue.isNotEmpty) {
    final node = queue.removeLast();
    if (node.path == value) {
      return node;
    }
    node.children.forEach(queue.add);
  }
  return null;
}

TreeNode? find3(TreeNode root, String value) {
  final queue = <TreeNode>[root];
  while (queue.isNotEmpty) {
    final node = queue.removeAt(0);
    if (node.path == value) {
      return node;
    }
    node.children.forEach(queue.add);
  }
  return null;
}

TreeNode? find4(TreeNode root, String value) {
  final queue = <TreeNode>[root];
  while (queue.isNotEmpty) {
    final node = queue.removeAt(0);
    if (node.path == value) {
      return node;
    }
    for (final child in node.children) {
      if (value.startsWith(child.path)) {
        queue.add(child);
      }
    }
  }
  return null;
}
