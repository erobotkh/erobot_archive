class Document {
  final List<Quiz> quiz;
  final List<ThingsUsed> components;
  final List<ThingsUsed> software;
  final List<Steps> steps;
  Document(
    this.quiz,
    this.components,
    this.software,
    this.steps,
  );
}

class Steps {
  final String text;
  final String picture;

  Steps(
    this.text,
    this.picture,
  );
}

class ThingsUsed {
  final String name;
  final String path;
  final String link;

  ThingsUsed(
    this.name,
    this.path,
    this.link,
  );
}

class Quiz {
  final String name;
  final List<String> answer;

  Quiz(
    this.name,
    this.answer,
  );
}
