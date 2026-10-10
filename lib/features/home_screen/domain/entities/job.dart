enum JobType { job, internship }

enum JobTech { computer, civil, electrical, mechanical, architecture, electronics }

class Job {
  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.type,
    required this.tech,
    required this.location,
    required this.salary,
    required this.deadline,
    required this.postedAt,
    required this.tags,
    required this.description,
  });

  final String id;
  final String title;
  final String company;
  final JobType type;
  final JobTech tech;
  final String location;
  final String salary;
  final DateTime deadline;
  final DateTime postedAt;
  final List<String> tags;
  final String description;
}
