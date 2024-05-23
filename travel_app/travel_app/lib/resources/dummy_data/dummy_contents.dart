import '../../data/models/accommodation.dart';

class DummyContent {
  final List<AccommodationObject> dummyAccommodations = [
    AccommodationObject(
      id: 1,
      name: "Cozy Cabin Retreat",
      location: "Mountain Village, Colorado",
      rate: 4.5,
      description:
          "Escape to this cozy cabin nestled in the heart of the Rocky Mountains.",
      photos: ["photo1.jpg", "photo2.jpg", "photo3.jpg"],
      photo:
          "https://plus.unsplash.com/premium_photo-1686090450467-3212162803e5?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 40,
    ),
    AccommodationObject(
      id: 2,
      name: "Luxury Beachfront Villa",
      location: "Maui, Hawaii",
      rate: 3.5,
      description:
          "Indulge in the ultimate luxury experience at this beachfront villa.",
      photos: ["photo4.jpg", "photo5.jpg", "photo6.jpg"],
      photo:
          "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 100,
    ),
    AccommodationObject(
      id: 3,
      name: "Serenity Cottage",
      location: "Lake District, England",
      rate: 4.2,
      description:
          "Find peace and tranquility at this charming cottage by the lake.",
      photos: ["photo7.jpg", "photo8.jpg", "photo9.jpg"],
      photo:
          "https://images.unsplash.com/photo-1646569278934-12d9533d0a3b?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 30,
    ),
    AccommodationObject(
      id: 4,
      name: "Urban Loft Apartment",
      location: "New York City, New York",
      rate: 2.6,
      description:
          "Experience city living at its finest in this modern loft apartment.",
      photos: ["photo10.jpg", "photo11.jpg", "photo12.jpg"],
      photo:
          "https://images.unsplash.com/photo-1605283176476-63150675f4a1?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 50,
    ),
    AccommodationObject(
      id: 5,
      name: "Rustic Mountain Lodge",
      location: "Banff, Alberta, Canada",
      rate: 4.1,
      description:
          "Embrace the beauty of the Canadian Rockies at this rustic mountain lodge.",
      photos: ["photo13.jpg", "photo14.jpg", "photo15.jpg"],
      photo:
          "https://images.unsplash.com/photo-1595521624742-47e90260edab?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 60,
    ),
    AccommodationObject(
      id: 6,
      name: "Seaside Bungalow",
      location: "Koh Samui, Thailand",
      rate: 3.9,
      description:
          "Wake up to stunning ocean views at this charming seaside bungalow.",
      photos: ["photo16.jpg", "photo17.jpg", "photo18.jpg"],
      photo:
          "https://images.unsplash.com/photo-1542365775-b0037a7c904f?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 80,
    ),
    AccommodationObject(
      id: 7,
      name: "Mountain Chalet",
      location: "Chamonix, France",
      rate: 3.8,
      description:
          "Escape to the French Alps and cozy up in this charming mountain chalet.",
      photos: ["photo19.jpg", "photo20.jpg", "photo21.jpg"],
      photo:
          "https://images.unsplash.com/photo-1649014232316-d1878df4cdaf?q=80&w=1635&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 50,
    ),
    AccommodationObject(
      id: 8,
      name: "Historic Townhouse",
      location: "Charleston, South Carolina",
      rate: 4.9,
      description:
          "Step back in time and stay in this beautifully restored historic townhouse.",
      photos: ["photo22.jpg", "photo23.jpg", "photo24.jpg"],
      photo:
          "https://images.unsplash.com/photo-1713468489423-14f2ca260b0e?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 40,
    ),
    AccommodationObject(
      id: 9,
      name: "Ski-In/Ski-Out Condo",
      location: "Whistler, British Columbia, Canada",
      rate: 4.6,
      description:
          "Hit the slopes from this convenient ski-in/ski-out condo in Whistler.",
      photos: ["photo25.jpg", "photo26.jpg", "photo27.jpg"],
      photo:
          "https://images.unsplash.com/photo-1515767049772-5ef369790604?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 100,
    ),
    AccommodationObject(
      id: 10,
      name: "Tropical Treehouse Retreat",
      location: "Bali, Indonesia",
      rate: 5.0,
      description:
          "Immerse yourself in nature at this unique tropical treehouse retreat.",
      photos: ["photo28.jpg", "photo29.jpg", "photo30.jpg"],
      photo:
          "https://plus.unsplash.com/premium_photo-1685305676839-26406ddbe4de?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      costPerPerson: 70,
    ),
  ];

  static const List<Map<String, String>> articleList = <Map<String, String>>[
    <String, String>{
      'title': "You Don't Know That You Know API Yet",
      'description':
          'Everyone says it, but how many of us know it? by Galip Erkin Doruk Full Stack Developer, Etrexio Application Programming Interface a.k.a API. Why does everyone need an API?...',
      'writer': 'Galip Erkin Doruk',
      'image': '',
    },
    <String, String>{
      'title': "You Don't Know That You Know API Yet",
      'description':
          'Everyone says it, but how many of us know it? by Galip Erkin Doruk Full Stack Developer, Etrexio Application Programming Interface a.k.a API. Why does everyone need an API?...',
      'writer': 'Galip Erkin Doruk',
      'image': '',
    },
    <String, String>{
      'title': "You Don't Know That You Know API Yet",
      'description':
          'Everyone says it, but how many of us know it? by Galip Erkin Doruk Full Stack Developer, Etrexio Application Programming Interface a.k.a API. Why does everyone need an API?...',
      'writer': 'Galip Erkin Doruk',
      'image': '',
    },
  ];
  static const String htmlContentForCaseDetail = """
<span style="font-size:2em">
Let's talk about
<br/>
<p style="color:red">Drool!</p>
</span>""";
}
