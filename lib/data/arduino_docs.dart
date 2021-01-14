import 'package:erobot_app/import/models.dart';

final List<Doc> docs = [
  Doc('How to change Name and Password of HC-05', 'Learn how to build a robot',
      0, 'arduino_doc.png', 'Sep 7, 2020'),
  Doc('Learn how to build a robot', 'Learn how to build a robot', 1,
      'arduino_doc.png', 'Sep 7, 2020'),
  Doc('Arduino Documents', 'Learn how to build a robot', 2, 'arduino_doc.png',
      'Sep 7, 2020'),
  Doc('Arduino Documents', 'Learn how to build a robot', 3, 'arduino_doc.png',
      'Sep 7, 2020'),
  Doc('Arduino Documents', 'Learn how to build a robot', 4, 'arduino_doc.png',
      'Sep 7, 2020'),
  Doc('Arduino Documents', 'Learn how to build a robot', 5, 'arduino_doc.png',
      'Sep 7, 2020'),
  Doc('Arduino Documents', 'Learn how to build a robot', 6, 'arduino_doc.png',
      'Sep 7, 2020'),
];

List<Document> doc = [
  Document(quiz, components, software, steps),
];

List<Steps> steps = [
  Steps(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquet et nulla euismod facilisis lectus orci malesuada viverra sit. Felis rhoncus, est ultrices habitant ut felis ultricies. Scelerisque iaculis est fermentum, dis nisl. Diam sed dapibus lorem eget at aenean semper suspendisse. Nec facilisi enim donec tristique. Pulvinar libero, nulla purus id malesuada rhoncus volutpat amet mi. Varius massa amet ultrices ipsum gravida ac vitae id. Ipsum nisl congue lacus a, enim diam. Velit, faucibus dis sed turpis eu ultricies nibh non.',
    'step1.png',
  ),
  Steps(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquet et nulla euismod facilisis lectus orci malesuada viverra sit. Felis rhoncus, est ultrices habitant ut felis ultricies. Scelerisque iaculis est fermentum, dis nisl. Diam sed dapibus lorem eget at aenean semper suspendisse. Nec facilisi enim donec tristique. Pulvinar libero, nulla purus id malesuada rhoncus volutpat amet mi. Varius massa amet ultrices ipsum gravida ac vitae id. Ipsum nisl congue lacus a, enim diam. Velit, faucibus dis sed turpis eu ultricies nibh non.',
    null,
  ),
  Steps(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquet et nulla euismod facilisis lectus orci malesuada viverra sit. Felis rhoncus, est ultrices habitant ut felis ultricies. Scelerisque iaculis est fermentum, dis nisl. Diam sed dapibus lorem eget at aenean semper suspendisse. Nec facilisi enim donec tristique. Pulvinar libero, nulla purus id malesuada rhoncus volutpat amet mi. Varius massa amet ultrices ipsum gravida ac vitae id. Ipsum nisl congue lacus a, enim diam. Velit, faucibus dis sed turpis eu ultricies nibh non.',
    'step1.png',
  )
];
List<ThingsUsed> software = [ThingsUsed('Arduino IDE', 'com1.png', 'link')];
List<ThingsUsed> components = [
  ThingsUsed('Arduino HC-05', 'com1.png', 'link'),
  ThingsUsed('Arduino HC-05', 'com2.png', 'link'),
  ThingsUsed('Arduino HC-05', 'com3.png', 'link'),
  ThingsUsed('Arduino HC-05', 'com4.png', 'link'),
  ThingsUsed('Arduino HC-05', 'com3.png', 'link'),
  ThingsUsed('Arduino HC-05', 'com4.png', 'link'),
];
List<Quiz> quiz = [
  Quiz("Why we have to change Arduino name?", answer),
  Quiz("Why we have to change Arduino name?", answer),
  Quiz("Why we have to change Arduino name?", answer),
  Quiz("Why we have to change Arduino name?", answer),
];

List<String> answer = [
  'Because we have to change Arduino HC-05 name',
  'Because we have to change Arduino HC-05 name',
  'Because we have to change Arduino HC-05 name',
  'Because we have to change Arduino HC-05 name',
];
