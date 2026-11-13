import 'profile_models.dart';

/// Sample payloads. They double as documentation of the JSON keys the
/// models read. Real API values (name, email, ...) always override these.
/// Switch off with `kUseDemoProfileData = false` in profile_repository.dart.
final demoStudentJson = {
  'polytechnic': 'Dinajpur Polytechnic Institute',
  'technology': 'Diploma in Computer Science & Technology (CST)',
  'bio':
      'A curious 8th-semester CST student looking for an industrial '
      'attachment at a software company to grow my technical skills.',
  'phone': '+8801789123456',
  'address': 'Upashahar, Dinajpur, Bangladesh',
  'currentStatus': '8th semester (attachment)',
  'cgpa': 3.85,
  'nocIssued': true,
  'nocNumber': 'DPI/ATTACH/2026/89',
  'boardRoll': '543211',
  'registration': '1502489231',
  'session': '2020-21',
  'cvUrl': 'https://drive.google.com',
  'ssc': {
    'school': 'Dinajpur Zilla School',
    'groupBoard': 'Science (Dinajpur Board)',
    'yearGpa': '2020 (GPA 5.00)',
  },
  'results': [
    {'semester': 1, 'year': 2021, 'gpa': 3.75},
    {'semester': 2, 'year': 2021, 'gpa': 3.80},
    {'semester': 3, 'year': 2022, 'gpa': 3.85},
  ],
  'skills': [
    {'name': 'HTML5, CSS3, Tailwind CSS', 'percent': 90},
    {'name': 'JavaScript (ES6+)', 'percent': 75},
    {'name': 'Python & MySQL', 'percent': 70},
  ],
  'projects': [
    {
      'title': 'Polytechnic Result Calculator',
      'category': 'Web app',
      'description':
          'Single-page GPA and weightage calculator for BTEB students.',
      'tags': ['JavaScript', 'Tailwind CSS'],
      'demoUrl': 'https://example.com',
      'repoUrl': 'https://github.com',
    },
  ],
  'applications': [
    {
      'company': 'Walton Hi-Tech Industries PLC',
      'role': 'PLC & Automation Training Intern',
      'type': 'attachment',
      'appliedAt': '2026-10-20',
      'status': 'shortlisted',
      'message': 'Lab test on 24 October',
    },
    {
      'company': 'SoftTech IT Bangladesh',
      'role': 'Junior Web Developer',
      'type': 'job',
      'appliedAt': '2026-10-18',
      'status': 'interview',
      'message': 'Interview link sent to your email',
    },
    {
      'company': 'Energypac Engineering Ltd.',
      'role': 'Industrial Attachment Trainee',
      'type': 'attachment',
      'appliedAt': '2026-10-15',
      'status': 'pending',
    },
  ],
  'certificates': [
    {'title': 'Web Development Fundamentals', 'issuer': 'BTEB & SEIP (2024)'},
    {'title': 'Python & Problem Solving', 'issuer': 'Coursera (2025)'},
  ],
  'socials': [
    {
      'type': 'linkedin',
      'label': 'LinkedIn Profile',
      'url': 'https://linkedin.com',
    },
    {
      'type': 'github',
      'label': 'GitHub Repositories',
      'url': 'https://github.com',
    },
  ],
};

final demoCompanyJson = {
  'industry': 'Electronics, Consumer Durables, Automation & IT Solutions',
  'location': 'Chandra, Gazipur, Bangladesh',
  'employees': 10000,
  'website': 'waltonbd.com',
  'verified': true,
  'btebPartner': true,
  'about':
      'Walton Hi-Tech Industries PLC is a leading manufacturer of consumer '
      'electronics and automation technology in Bangladesh. Every year we '
      'offer industrial attachments and sub-assistant engineer roles to '
      'BTEB-approved polytechnic students.',
  'hrEmail': 'careers@waltonbd.com',
  'hrPhone': '+880 9612-888888',
  'address': 'Chandra, Kaliakair, Gazipur, Bangladesh',
  'domains': [
    {
      'title': 'PLC & Robotic Automation',
      'subtitle': 'Automated assembly lines',
    },
    {'title': 'HVAC & Power Grid', 'subtitle': 'Substations and power plants'},
    {
      'title': 'Software & Enterprise ERP',
      'subtitle': 'Software and IT solutions',
    },
  ],
  'benefits': [
    'Fixed monthly stipend',
    'Free accommodation',
    'Transport subsidy',
    'Permanent job on performance',
    'Attachment certificate',
    'Cafeteria subsidy',
  ],
  'postings': [
    {
      'id': 'p1',
      'title': 'PLC & Industrial Automation Trainee',
      'tech': 'Electrical, Mechatronics, Computer',
      'type': 'attachment',
      'seats': 25,
      'tags': ['Free housing', 'Cafeteria subsidy', 'NOC required'],
      'location': 'Chandra Plant, Gazipur',
      'salary': '৳ 8,000/month',
      'deadline': '2026-10-30',
      'applicants': 54,
    },
    {
      'id': 'p2',
      'title': 'Junior Sub-Assistant Engineer (HVAC & Power)',
      'tech': 'Mechanical, Power, RAC',
      'type': 'job',
      'seats': 12,
      'tags': ['Festival bonus', 'Provident fund'],
      'location': 'Chandra Factory Complex',
      'salary': '৳ 25,000 - 30,000',
      'deadline': '2026-11-15',
      'applicants': 68,
    },
    {
      'id': 'p3',
      'title': 'Web Development & ERP Intern (CST)',
      'tech': 'Computer Science (CST)',
      'type': 'attachment',
      'seats': 10,
      'tags': ['Certificate provided'],
      'location': 'Bashundhara Corporate Office, Dhaka',
      'salary': '৳ 10,000/month',
      'deadline': '2026-11-20',
      'applicants': 42,
    },
  ],
  'applicants': [
    {
      'id': 'a1',
      'name': 'Md. Nice Islam',
      'polytechnic': 'Dinajpur Polytechnic Institute',
      'technology': 'Computer (CST)',
      'cgpa': 3.85,
      'type': 'attachment',
      'position': 'PLC Trainee',
      'cvUrl': 'https://drive.google.com',
      'nocAttached': true,
      'status': 'shortlisted',
    },
    {
      'id': 'a2',
      'name': 'Arifur Rahman',
      'polytechnic': 'Dhaka Polytechnic Institute',
      'technology': 'Electrical (EEE)',
      'cgpa': 3.92,
      'type': 'job',
      'position': 'Jr. Sub-Assistant Engineer',
      'cvUrl': 'https://drive.google.com',
      'status': 'interview',
      'interviewAt': '2026-10-24 10:00',
    },
    {
      'id': 'a3',
      'name': 'Sadia Afrin',
      'polytechnic': 'Bogura Polytechnic Institute',
      'technology': 'Computer (CST)',
      'cgpa': 3.78,
      'type': 'attachment',
      'position': 'Web Dev Intern',
      'cvUrl': 'https://drive.google.com',
      'status': 'pending',
    },
  ],
  'partners': [
    {'name': 'Dhaka Polytechnic Institute', 'quota': 50},
    {'name': 'Dinajpur Polytechnic Institute', 'quota': 35},
    {'name': 'Bogura Polytechnic Institute', 'quota': 30},
  ],
};
