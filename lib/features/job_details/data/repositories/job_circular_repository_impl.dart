import '../../domain/entities/job_circular.dart';
import '../../domain/repositories/job_circular_repository.dart';

/// In-memory implementation seeded with the design's sample data.
class MockJobCircularRepository implements JobCircularRepository {
  final Set<String> _bookmarks = {};
  final Map<String, MyApplication> _applications = {};

  @override
  Future<JobDetails> fetchDetails(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return JobDetails(
      circular: _circular(id),
      isBookmarked: _bookmarks.contains(id),
      application: _applications[id],
    );
  }

  @override
  Future<bool> setBookmark(String id, {required bool value}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    value ? _bookmarks.add(id) : _bookmarks.remove(id);
    return value;
  }

  @override
  Future<MyApplication> submitApplication(
    String id,
    ApplicationDraft draft,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return _applications[id] = MyApplication(
      appliedAt: DateTime.now(),
      status: ReviewStatus.pending,
      message: 'আপনার আবেদনপত্র এইচআর টিম পর্যালোচনা করছে',
    );
  }

  JobCircular _circular(String id) => JobCircular(
        id: id,
        title: 'Junior Sub-Assistant Engineer (Automation & Robotics)',
        type: CircularType.attachment,
        semester: 8,
        isVerifiedEmployer: true,
        company: const Company(
          name: 'ওয়ালটন হাই-টেক ইন্ডাস্ট্রিজ পিএলসি',
          logoUrl:
              'https://images.unsplash.com/photo-1560179707-f14e90ef3623?auto=format&fit=crop&q=80&w=200',
          tagline: 'বাংলাদেশ কারিগরি শিক্ষা বোর্ড (BTEB) অনুমোদিত শিল্প প্রতিষ্ঠান',
          about:
              'ওয়ালটন হাই-টেক ইন্ডাস্ট্রিজ পিএলসি বাংলাদেশের শীর্ষস্থানীয় ইলেকট্রনিক্স ও প্রযুক্তিপণ্য প্রস্তুতকারক। পলিটেকনিক শিক্ষার্থীদের দক্ষ মানবসম্পদে উন্নীত করতে ওয়ালটন প্রতি বছর শত শত ডিপ্লোমা ছাত্র-ছাত্রীদের আধুনিক কারখানায় প্র্যাকটিক্যাল ট্রেনিং প্রদান করে থাকে।',
        ),
        technologies: const ['CST', 'EEE', 'Robotics & Mechatronics'],
        location: 'চন্দ্রা, গাজীপুর',
        stipend: 12000,
        deadline: DateTime(2026, 11, 15),
        publishedAt: DateTime(2026, 10, 20),
        vacancies: 15,
        employmentType: 'ইন্ডাস্ট্রিয়াল ইন্টার্নশিপ',
        educationLabel: 'ডিপ্লোমা ইন ইঞ্জিনিয়ারিং (BTEB)',
        housing: 'ফ্রি (কোম্পানি হোস্টেল)',
        overview:
            'ওয়ালটন হাই-টেক ইন্ডাস্ট্রিজ পিএলসি তার বিশ্বমানের স্মার্ট প্লাগ ও ইলেকট্রনিক্স অটোমেশন প্ল্যান্টের জন্য ৮ম সেমিস্টারের ডিপ্লোমা ইন ইঞ্জিনিয়ারিং শিক্ষার্থীদের কাছ থেকে ইন্ডাস্ট্রিয়াল অ্যাটাচমেন্ট ও ট্রেইনি ইঞ্জিনিয়ার পদের জন্য আবেদন আহ্বান করছে। এই প্রোগ্রামের লক্ষ্য হল শিক্ষার্থীদের আধুনিক ইন্ডাস্ট্রি ৪.০ রোবোটিক্স, পিএলসি কন্ট্রোল লজিক এবং আইওটি সিস্টেমের বাস্তব অভিজ্ঞতা প্রদান করা।',
        responsibilities: const [
          'স্বয়ংক্রিয় ইন্ডাস্ট্রিয়াল অ্যাসেম্বলি লাইনে Siemens ও Mitsubishi PLC প্রোগামিং মনিটরিং ও ট্রাবলশুটিং করা।',
          'রোবোটিক আর্মের সঠিক অপারেশনাল পারফরম্যান্স নিশ্চিত করতে নিয়মিত প্রিভেন্টিভ মেইনটেন্যান্স সহায়তা।',
          'আইওটি সেন্সর ডেটা সংগ্রহ ও প্ল্যান্টের ERP ড্যাশবোর্ডে রিয়েল-টাইম তথ্য আপডেট রাখা।',
          'সিনিয়র সাব-অ্যাসিস্ট্যান্ট ইঞ্জিনিয়ারদের সাথে দৈনিক প্রোডাকশন শিডিউল ও রিপোর্ট তৈরিতে কাজ করা।',
        ],
        requirements: const [
          'শিক্ষাগত যোগ্যতা: বাংলাদেশ কারিগরি শিক্ষা বোর্ড (BTEB) স্বীকৃত যেকোনো পলিটেকনিক ইনস্টিটিউট হতে ডিপ্লোমা ইন ইঞ্জিনিয়ারিং অধ্যয়নরত।',
          'প্রযোজ্য টেকনোলজি: কম্পিউটার (CST), ইলেকট্রিক্যাল (EEE), মেকাট্রনিক্স অথবা ইলেকট্রনিক্স।',
          'ন্যূনতম CGPA: ৭ম সেমিস্টার পর্যন্ত ৩.২০ বা তদূর্ধ্ব প্রাপ্তদের অগ্রাধিকার প্রদান করা হবে।',
          'ইনস্টিটিউটের NOC (No Objection Certificate) প্রদান করতে হবে।',
        ],
        benefits: const [
          'মাসিক ফিক্সড স্টাইপেন্ড ৳ ১২,০০০',
          'কোম্পানির সুসজ্জিত ফ্রি আবাসন সুবিধা',
          'ক্যাফেটেরিয়াতে ভর্তুকিমূল্যে খাবার',
          'ইন্টার্নশিপ শেষে সরাসরি স্থায়ী চাকরি',
          'শিল্প অ্যাটাচমেন্ট অফিসিয়াল সনদপত্র',
          'বিনামূল্যে ফ্যাক্টরি ট্রান্সপোর্ট রুট',
        ],
        requiredDocuments: const [
          'আপডেটকৃত সিভি (PDF Format)',
          'পলিটেকনিক ইনস্টিটিউট প্রধান কর্তৃক ইস্যুকৃত NOC বা ছাড়পত্র',
          '১ম থেকে ৭ম সেমিস্টারের ট্রান্সক্রিপ্ট/মার্কশিট কপি',
        ],
        hr: const HrContact(
          email: 'attachment@waltonbd.com',
          phone: '+880 9612-88888',
          websiteLabel: 'waltonbd.com/careers',
          websiteUrl: 'https://waltonbd.com',
        ),
        related: const [
          RelatedCircular(
            id: 'r1',
            title: 'Junior Sub-Assistant Engineer (HVAC)',
            companyName: 'সামিট পাওয়ার লিমিটেড',
            location: 'ঢাকা',
            type: CircularType.job,
          ),
          RelatedCircular(
            id: 'r2',
            title: 'Web & ERP Support Trainee (CST)',
            companyName: 'স্যামসাং আরএন্ডডি বিডি',
            location: 'ঢাকা',
            type: CircularType.attachment,
            semester: 8,
          ),
        ],
      );
}
