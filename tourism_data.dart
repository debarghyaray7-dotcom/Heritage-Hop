import '../models/tourism_models.dart';

class TourismData {
  // ─── Cities ───────────────────────────────────────────────────────────────
  static const List<City> cities = [
    City(
      id: 'kolkata',
      name: 'Kolkata',
      state: 'West Bengal',
      description:
      'The City of Joy — where culture, art, and heritage blend with modernity.',
      imageUrl: 'assets/images/kolkata.jpg',
      latitude: 22.5726,
      longitude: 88.3639,
      bestSeason: 'October – February',
      language: 'Bengali, Hindi, English',
    ),
    City(
      id: 'jaipur',
      name: 'Jaipur',
      state: 'Rajasthan',
      description:
      'The Pink City — a royal tapestry of forts, palaces, and vibrant bazaars.',
      imageUrl: 'assets/images/jaipur.jpg',
      latitude: 26.9124,
      longitude: 75.7873,
      bestSeason: 'November – February',
      language: 'Rajasthani, Hindi',
    ),
    City(
      id: 'delhi',
      name: 'Delhi',
      state: 'Delhi NCR',
      description:
      'India\'s capital — a city where every lane holds centuries of history.',
      imageUrl: 'assets/images/delhi.jpg',
      latitude: 28.6139,
      longitude: 77.2090,
      bestSeason: 'October – March',
      language: 'Hindi, Punjabi, Urdu',
    ),
    City(
      id: 'varanasi',
      name: 'Varanasi',
      state: 'Uttar Pradesh',
      description:
      'The Spiritual Capital — the world\'s oldest living city on the Ganges.',
      imageUrl: 'assets/images/varanasi.jpg',
      latitude: 25.3176,
      longitude: 82.9739,
      bestSeason: 'October – February',
      language: 'Hindi, Bhojpuri',
    ),
  ];

  // ─── Places ───────────────────────────────────────────────────────────────
  static final List<TourismPlace> places = [

    // ══════════════════════════════════════════════════════════════════════════
    // KOLKATA
    // ══════════════════════════════════════════════════════════════════════════

    TourismPlace(
      id: 'victoria_memorial',
      name: 'Victoria Memorial',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'A majestic marble monument dedicated to Queen Victoria, now a world-class museum.',
      fullDescription:
      'The Victoria Memorial is a large marble building in Kolkata built between 1906 and 1921. Dedicated to Queen Victoria, Empress of India, it is now a museum under the Ministry of Culture. Built from Makrana marble and set in 64 acres of landscaped gardens, it is one of the finest examples of British Indo-Saracenic architecture. The museum houses over 25,000 artefacts including paintings, sculptures, arms, maps, and coins.',
      imageUrl: 'assets/images/victoria_memorial.jpg',
      galleryImages: [
        'assets/images/victoria_memorial.jpg',
        'assets/images/kolkata.jpg',
      ],
      rating: 4.7,
      reviewCount: 28450,
      entryFee: '₹30 (Indian) / ₹500 (Foreign)',
      timing: '10:00 AM – 5:00 PM (Closed Monday)',
      bestTimeToVisit: 'October to March',
      latitude: 22.5448,
      longitude: 88.3426,
      address: '1, Queens Way, Kolkata 700071',
      nearbyTransport: [
        '🚇 Metro: Maidan Station (5 min walk)',
        '🚌 Bus: Route 12, 230 stop nearby',
        '🛺 Auto from Park Street: ₹30–50',
        '🟡 Yellow Taxi from Howrah: ₹80–120',
      ],
      travelTips: [
        'Book tickets online to skip the queue',
        'Evening light & sound show is spectacular',
        'Best photography at golden hour (5–6 PM)',
        'Avoid summer months (April–June)',
        'The surrounding gardens are free to enter',
      ],
      estimatedBudget: '₹200–400 per person',
      nearbyFood: [
        'Mocambo Restaurant',
        'Peter Cat',
        'Flurys Bakery',
        'Momo stalls at Park Street',
      ],
      nearbyHotels: [
        'The Oberoi Grand',
        'Park Hotel Kolkata',
        'Vivanta Kolkata',
      ],
    ),

    TourismPlace(
      id: 'howrah_bridge',
      name: 'Howrah Bridge',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'Iconic cantilever bridge over the Hooghly River — an enduring symbol of Kolkata.',
      fullDescription:
      'Howrah Bridge (Rabindra Setu) is a balanced cantilever bridge commissioned in 1943. It is one of the busiest bridges in the world carrying ~100,000 vehicles daily. The 705-metre bridge was constructed entirely with rivets — no nuts or bolts. It was later renamed in honour of Nobel laureate Rabindranath Tagore. The bridge is even more stunning at night when it is beautifully illuminated.',
      imageUrl: 'assets/images/howrah_bridge.jpg',
      galleryImages: [
        'assets/images/howrah_bridge.jpg',
      ],
      rating: 4.5,
      reviewCount: 42000,
      entryFee: 'Free',
      timing: 'Open 24 hours',
      bestTimeToVisit: 'Early morning or evening',
      latitude: 22.5851,
      longitude: 88.3468,
      address: 'Howrah Bridge, Howrah, West Bengal 711101',
      nearbyTransport: [
        '🚢 Ferry from Babu Ghat: ₹5',
        '🚌 Bus: Multiple routes to Howrah Station',
        '🚇 Metro: Howrah Maidan (nearby)',
        '🛺 Auto from BBD Bagh: ₹40–60',
      ],
      travelTips: [
        'Photography is restricted on the bridge itself',
        'Take the Ganga ferry for the best panoramic views',
        'Visit during Durga Puja for a festive atmosphere',
        'Walk across early morning for an immersive experience',
        'Flower market at Mullick Ghat nearby is stunning at dawn',
      ],
      estimatedBudget: '₹50–150 (ferry + chai)',
      nearbyFood: [
        'Dacres Lane tea stalls',
        'Anand Restaurant',
        'Basanti Sweets',
      ],
      nearbyHotels: [
        'Hotel Hindusthan International',
        'Lytton Hotel',
        'The Heritage',
      ],
    ),

    TourismPlace(
      id: 'college_street',
      name: 'College Street & Coffee House',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'The intellectual heart of Kolkata — world\'s largest second-hand book market.',
      fullDescription:
      'College Street is famous for the Indian Coffee House and the largest second-hand book market in the world. Once the haunt of Nobel laureates and revolutionaries, this street witnessed some of the most important intellectual discussions in Indian history. The Indian Coffee House has been a cultural institution since 1942, attracting writers, poets, and thinkers for decades.',
      imageUrl: 'assets/images/college_street.jpg',
      galleryImages: [
        'assets/images/college_street.jpg',
      ],
      rating: 4.3,
      reviewCount: 12000,
      entryFee: 'Free',
      timing: '8:00 AM – 8:00 PM',
      bestTimeToVisit: 'Weekday mornings',
      latitude: 22.5786,
      longitude: 88.3607,
      address: 'College Street, Kolkata 700073',
      nearbyTransport: [
        '🚌 Bus from Esplanade: ₹8',
        '🚇 Metro: Central Station (5 min walk)',
        '🛺 Auto from Shyambazar: ₹30',
      ],
      travelTips: [
        'Bargain hard — book prices are very negotiable',
        'Indian Coffee House coffee is excellent and cheap (₹20)',
        'Explore Presidency University campus nearby',
        'Weekday mornings have fewer crowds and fresher stock',
        'Look for rare Bengali literary works and vintage maps',
      ],
      estimatedBudget: '₹100–300 (books + coffee)',
      nearbyFood: [
        'Indian Coffee House',
        'Favourite Cabin',
        'Putiram Sweets',
      ],
      nearbyHotels: ['Hotel Astoria', 'Ginger Hotel Kolkata', 'YMCA'],
    ),

    TourismPlace(
      id: 'sundarbans',
      name: 'Sundarbans National Park',
      cityId: 'kolkata',
      category: 'attraction',
      description:
      'UNESCO World Heritage — world\'s largest mangrove forest, home to Royal Bengal Tigers.',
      fullDescription:
      'The Sundarbans is the world\'s largest mangrove delta formed by the Ganges, Brahmaputra and Meghna rivers. It spans West Bengal and Bangladesh and is home to approximately 500 Royal Bengal Tigers. It is a UNESCO World Heritage Site and Ramsar wetland of international importance. The boat safaris through its dense waterways are an experience unlike any other in India.',
      imageUrl: 'assets/images/sundarbans.jpg',
      galleryImages: [
        'assets/images/sundarbans.jpg',
      ],
      rating: 4.6,
      reviewCount: 8900,
      entryFee: '₹500 (Indian) / ₹1000 (Foreign) + Boat',
      timing: '6:00 AM – 5:00 PM',
      bestTimeToVisit: 'November to February',
      latitude: 21.9497,
      longitude: 89.1833,
      address: 'Sundarbans, South 24 Parganas, West Bengal',
      nearbyTransport: [
        '🚌 Bus Esplanade → Canning: ₹50',
        '🚢 Ferry from Canning to Gosaba',
        '🚂 Train Sealdah → Canning: ₹20',
        '🛵 Toto/Auto at Gosaba: ₹30–50',
      ],
      travelTips: [
        'Book guided boat tours at least a week in advance',
        'Carry strong insect repellent — essential',
        'Never venture alone or outside designated zones',
        'Wildlife safaris are best at dawn (5–7 AM)',
        'Carry drinking water and snacks — options are limited',
      ],
      estimatedBudget: '₹2500–4000 for 2-day package',
      nearbyFood: [
        'Local fish curry at Gosaba',
        'Mud crab dishes',
        'Prawn fry at riverside stalls',
      ],
      nearbyHotels: [
        'Sundarban Tiger Camp',
        'Sajnekhali Tourist Lodge',
        'Sunderban Jungle Camp',
      ],
    ),

    // ── NEW KOLKATA PLACES ────────────────────────────────────────────────────

    TourismPlace(
      id: 'kalighat_temple',
      name: 'Kalighat Kali Temple',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'One of the 51 Shakti Peethas — Kolkata\'s most sacred and ancient Hindu temple.',
      fullDescription:
      'Kalighat Kali Temple is one of the most sacred Hindu temples in India, dedicated to Goddess Kali. It is one of the 51 Shakti Peethas — places where body parts of Sati are believed to have fallen. The current temple structure dates back to 1809 and is built in the traditional Bengali aat-chala style. Thousands of pilgrims visit daily, and the spiritual energy here is palpable. The narrow lanes around the temple are lined with flower sellers and prasad stalls.',
      imageUrl: 'assets/images/kalighat.png',
      galleryImages: [
        'assets/images/kalighat.png',
      ],
      rating: 4.6,
      reviewCount: 32000,
      entryFee: 'Free (Prasad: ₹50–200)',
      timing: '5:00 AM – 10:00 PM',
      bestTimeToVisit: 'Early morning (5–7 AM) or Kali Puja',
      latitude: 22.5197,
      longitude: 88.3432,
      address: 'Kalighat, Kolkata 700026',
      nearbyTransport: [
        '🚇 Metro: Kalighat Station (2 min walk)',
        '🚌 Bus: Routes 45, 230 stop nearby',
        '🛺 Auto from Rashbehari: ₹30',
        '🟡 Yellow Taxi from Park Street: ₹60–80',
      ],
      travelTips: [
        'Visit at dawn for the most spiritual atmosphere',
        'Dress modestly — cover shoulders and knees',
        'Keep valuables secure in the crowded lanes',
        'Purchase fresh flowers at Kalighat flower market',
        'Combine with a walk along the Adi Ganga (Tolly\'s Nullah)',
      ],
      estimatedBudget: '₹150–300 per person',
      nearbyFood: [
        'Balaram Mullick & Radharaman Mullick (sweets)',
        'Kasturi Restaurant',
        'Shiraz Golden Restaurant',
      ],
      nearbyHotels: [
        'Hindustan International',
        'The Tollygunge Club',
        'Kenilworth Hotel',
      ],
    ),

    TourismPlace(
      id: 'science_city',
      name: 'Science City Kolkata',
      cityId: 'kolkata',
      category: 'attraction',
      description:
      'India\'s largest science centre — an immersive, interactive world of discovery.',
      fullDescription:
      'Science City, Kolkata is the largest science centre in the Indian subcontinent, run by the National Council of Science Museums. It features a Space Odyssey ride, Evolution Park, Maritime Centre, and a Dynamotion Hall with interactive exhibits. The 20-acre campus is a perfect blend of education and entertainment, ideal for all ages. The Space Theatre with its domed screen offers breathtaking planetarium shows.',
      imageUrl: 'assets/images/science_city.jpg',
      galleryImages: [
        'assets/images/science_city.jpg',
      ],
      rating: 4.4,
      reviewCount: 19500,
      entryFee: '₹60 (Indian) / ₹200 (Foreign) + Rides extra',
      timing: '9:00 AM – 8:00 PM (All days)',
      bestTimeToVisit: 'Weekday mornings',
      latitude: 22.5358,
      longitude: 88.3954,
      address: 'JBS Haldane Ave, Kolkata 700046',
      nearbyTransport: [
        '🚇 Metro: Science City Station (1 min walk)',
        '🚌 Bus: Routes 6, 45B, 230A',
        '🛺 Auto from EM Bypass: ₹20–30',
        '🚖 Uber/Ola from Park Street: ₹80–120',
      ],
      travelTips: [
        'Buy a combo ticket for all rides — better value',
        'Space Theatre shows are 30 min each — book at entry',
        'Carry a water bottle — the campus is large',
        'Weekends get very crowded; go on weekdays',
        'Evolution Park walk takes about 45 minutes',
      ],
      estimatedBudget: '₹300–600 per person (with rides)',
      nearbyFood: [
        'Cafe inside Science City',
        'Momo stalls on JBS Haldane Ave',
        'Mainland China (nearby)',
      ],
      nearbyHotels: [
        'Hyatt Regency Kolkata',
        'ITC Sonar',
        'Novotel Kolkata',
      ],
    ),

    TourismPlace(
      id: 'dakshineswar_temple',
      name: 'Dakshineswar Kali Temple',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'A magnificent riverside temple where Ramakrishna Paramahamsa attained enlightenment.',
      fullDescription:
      'The Dakshineswar Kali Temple is a Hindu temple located on the eastern bank of the Hooghly River in Dakshineswar. Built in 1855 by Rani Rashmoni, it is a nine-spire (navaratna) temple dedicated to Goddess Bhavatarini — a form of Kali. Sri Ramakrishna Paramahamsa served as the head priest here and attained divine enlightenment on these very grounds. The 12 Shiva temples and the Radha-Krishna temple within the complex add to its spiritual grandeur.',
      imageUrl: 'assets/images/dakshineswar.jpg',
      galleryImages: [
        'assets/images/dakshineswar.jpg',
      ],
      rating: 4.7,
      reviewCount: 41000,
      entryFee: 'Free',
      timing: '6:00 AM – 12:30 PM, 3:00 PM – 8:30 PM',
      bestTimeToVisit: 'Early morning or evening aarti',
      latitude: 22.6547,
      longitude: 88.3578,
      address: 'Dakshineswar, Kolkata 700076',
      nearbyTransport: [
        '🚇 Metro: Dakshineswar Station (10 min walk)',
        '🚌 Bus: Routes from Shyambazar, Esplanade',
        '🚢 Ferry from Belur Math across the river',
        '🛺 Auto from Dunlop: ₹25–40',
      ],
      travelTips: [
        'Combine with Belur Math — only 15 min by ferry',
        'Arrive before 8 AM to avoid long queues',
        'Remove footwear before entering the main complex',
        'The riverside ghats are beautiful for peaceful walks',
        'Evenings offer spectacular views of the illuminated temple',
      ],
      estimatedBudget: '₹100–250 per person',
      nearbyFood: [
        'Prasad stalls inside the complex',
        'Adi Dakshineswar Mishti',
        'Riverside tea stalls',
      ],
      nearbyHotels: [
        'Hotel Savera',
        'Ginger Hotel Kolkata',
        'Hotel Galaxy',
      ],
    ),

    TourismPlace(
      id: 'indian_museum',
      name: 'Indian Museum',
      cityId: 'kolkata',
      category: 'heritage',
      description:
      'The oldest and largest museum in Asia — a treasure trove of 100,000+ artefacts.',
      fullDescription:
      'The Indian Museum in Kolkata is the oldest museum in Asia, established in 1814 by the Asiatic Society of Bengal. It houses over 100,000 artefacts spread across 6 sections and 35 galleries — including a rare collection of Egyptian mummies, Indus Valley artefacts, Mughal miniature paintings, rare fossils, and Buddhist relics from Sanchi. The neoclassical building itself is a heritage landmark. A visit here is an essential cultural experience for anyone in Kolkata.',
      imageUrl: 'assets/images/indian_museum.jpg',
      galleryImages: [
        'assets/images/indian_museum.jpg',
      ],
      rating: 4.4,
      reviewCount: 22000,
      entryFee: '₹20 (Indian) / ₹650 (Foreign)',
      timing: '10:00 AM – 5:00 PM (Closed Monday)',
      bestTimeToVisit: 'Weekday mornings',
      latitude: 22.5574,
      longitude: 88.3510,
      address: '27, Jawaharlal Nehru Rd, Kolkata 700016',
      nearbyTransport: [
        '🚇 Metro: Park Street Station (5 min walk)',
        '🚌 Bus: Routes 12, 45 stop on JL Nehru Rd',
        '🛺 Auto from Esplanade: ₹25',
        '🟡 Yellow Taxi from New Market: ₹30–40',
      ],
      travelTips: [
        'Allow at least 3 hours — the museum is vast',
        'The Egyptian mummy gallery is unmissable',
        'Hire an official guide for deeper historical context',
        'Combine with a Park Street café visit afterwards',
        'Photography is allowed in most galleries',
      ],
      estimatedBudget: '₹150–350 per person',
      nearbyFood: [
        'Flury\'s on Park Street',
        'Peter Cat Restaurant',
        'Bar-B-Q Restaurant',
      ],
      nearbyHotels: [
        'The Oberoi Grand',
        'Park Hotel Kolkata',
        'Taj Bengal',
      ],
    ),

    TourismPlace(
      id: 'new_market',
      name: 'New Market (Hogg\'s Market)',
      cityId: 'kolkata',
      category: 'attraction',
      description:
      'Kolkata\'s legendary 150-year-old bazaar — the ultimate local shopping experience.',
      fullDescription:
      'New Market, officially called Sir Stuart Hogg Market, was established in 1874 and is one of Kolkata\'s most iconic shopping destinations. Spread across a vast area with over 2,000 stalls, it sells everything from fresh flowers and spices to saris, leather goods, electronics, and antiques. The old Gothic building with its clock tower is architecturally stunning. Navigating New Market with a local guide unlocks hidden stalls and the best deals in the city.',
      imageUrl: 'assets/images/new_market.jpg',
      galleryImages: [
        'assets/images/new_market.jpg',
      ],
      rating: 4.2,
      reviewCount: 15500,
      entryFee: 'Free',
      timing: '10:00 AM – 8:00 PM (Closed Sunday)',
      bestTimeToVisit: 'Weekday mornings (avoid peak hours)',
      latitude: 22.5590,
      longitude: 88.3512,
      address: 'Lindsay Street, Kolkata 700087',
      nearbyTransport: [
        '🚇 Metro: Esplanade / Park Street (5 min)',
        '🚌 Bus: Multiple routes to Esplanade',
        '🛺 Auto from Park Street: ₹20',
        '🟡 Yellow Taxi easily available',
      ],
      travelTips: [
        'Always bargain — prices start 2–3× higher',
        'Visit the underground spice market for a sensory experience',
        'The flower section near the entrance is beautiful at dawn',
        'Keep cash handy — most stalls don\'t accept cards',
        'Nizam\'s nearby for the best Kathi roll in Kolkata',
      ],
      estimatedBudget: '₹500–2000 (shopping dependent)',
      nearbyFood: [
        'Nizam\'s (Kathi Roll)',
        'Kalika (kachori, puri)',
        'Nahoum\'s Confectionery',
      ],
      nearbyHotels: [
        'The Oberoi Grand',
        'YMCA International Guest House',
        'Hotel Lytton',
      ],
    ),

    TourismPlace(
      id: 'eco_park',
      name: 'Eco Park (Prakriti Tirtha)',
      cityId: 'kolkata',
      category: 'attraction',
      description:
      'Asia\'s largest urban eco-park — a stunning 480-acre green escape in New Town.',
      fullDescription:
      'Eco Park, also known as Prakriti Tirtha, is a sprawling 480-acre urban park in New Town, Kolkata. It features a large lake with boating facilities, themed gardens representing the Seven Wonders of the World, butterfly enclosures, cycling tracks, and open-air amphitheatres. Built by HIDCO, it is one of Asia\'s largest urban parks and offers a perfect day-long escape from the city. The park is especially magical at sunset and hosts cultural events throughout the year.',
      imageUrl: 'assets/images/eco_park.jpg',
      galleryImages: [
        'assets/images/eco_park.jpg',
      ],
      rating: 4.3,
      reviewCount: 28000,
      entryFee: '₹30 (Adult) / ₹15 (Child)',
      timing: '2:30 PM – 8:30 PM (Weekdays), 12:00 PM – 8:30 PM (Weekends)',
      bestTimeToVisit: 'Late afternoon for sunset views',
      latitude: 22.5952,
      longitude: 88.4673,
      address: 'New Town, Action Area II, Kolkata 700161',
      nearbyTransport: [
        '🚇 Metro: New Town/Eco Park Station',
        '🚌 AC Bus: Routes from Salt Lake',
        '🚖 Uber/Ola from Salt Lake Sector V: ₹60–100',
        '🚲 Rent a cycle inside the park: ₹50/hour',
      ],
      travelTips: [
        'Reach by 3 PM on weekdays for fewer crowds',
        'Boating tickets sell out fast on weekends — book early',
        'Rent a cycle to cover the full 480 acres comfortably',
        'The Seven Wonders replicas are a fun photo opportunity',
        'Carry mosquito repellent for evening visits near the lake',
      ],
      estimatedBudget: '₹150–350 per person (with activities)',
      nearbyFood: [
        'Food court inside the park',
        'Biryani stalls at New Town entrance',
        'Café Ekante inside the park',
      ],
      nearbyHotels: [
        'Swissotel Kolkata',
        'Hyatt Regency',
        'The Lalit Great Eastern',
      ],
    ),

    // ══════════════════════════════════════════════════════════════════════════
    // JAIPUR
    // ══════════════════════════════════════════════════════════════════════════

    TourismPlace(
      id: 'amber_fort',
      name: 'Amber Fort',
      cityId: 'jaipur',
      category: 'heritage',
      description:
      'A grand 16th-century Rajput fort overlooking Maota Lake — UNESCO World Heritage Site.',
      fullDescription:
      'Amber Fort is located 11 km from Jaipur on a hilltop. Built in 1592 by Raja Man Singh I and later extended by Mirza Raja Jai Singh, the fort is known for its artistic style elements, large ramparts, series of gates and cobbled paths. The Sheesh Mahal (Hall of Mirrors) is its most stunning interior.',
      imageUrl: 'assets/images/jaipur.jpg',
      galleryImages: [
        'assets/images/jaipur.jpg',
      ],
      rating: 4.8,
      reviewCount: 65000,
      entryFee: '₹100 (Indian) / ₹500 (Foreign)',
      timing: '8:00 AM – 5:30 PM',
      bestTimeToVisit: 'October to March',
      latitude: 26.9855,
      longitude: 75.8513,
      address: 'Devisinghpura, Amer, Jaipur, Rajasthan 302001',
      nearbyTransport: [
        '🚌 Bus from Hawa Mahal: ₹20 (Route 5)',
        '🛺 Auto from Jaipur center: ₹150–200',
        '🐘 Elephant ride (inside fort): ₹900',
        '🚕 Cab from Pink City: ₹200–300',
      ],
      travelTips: [
        'Hire a local guide for historical context',
        'Combine with Jaigarh Fort (connected via path)',
        'Night illumination show starts at 7 PM',
        'Avoid midday heat in summer',
      ],
      estimatedBudget: '₹500–1000 per person',
      nearbyFood: [
        'Amer ki Chai (Masala Tea)',
        'Pyaaz Kachori stalls',
        'Shri Thali Restaurant',
      ],
      nearbyHotels: [
        'Samode Palace',
        'Dera Amer',
        'Hotel Hilltop',
      ],
    ),

    TourismPlace(
      id: 'hawa_mahal',
      name: 'Hawa Mahal',
      cityId: 'jaipur',
      category: 'heritage',
      description:
      'The Palace of Winds — a stunning 953-windowed pink sandstone façade.',
      fullDescription:
      'Built in 1799 by Maharaja Sawai Pratap Singh, Hawa Mahal\'s five-storey exterior resembles a honeycomb with 953 small jharokha windows decorated with intricate latticework. The design allowed royal ladies to observe street life without being seen, while the lattice ensured cool breeze circulation.',
      imageUrl: 'assets/images/jaipur.jpg',
      galleryImages: [
        'assets/images/jaipur.jpg',
      ],
      rating: 4.6,
      reviewCount: 89000,
      entryFee: '₹50 (Indian) / ₹200 (Foreign)',
      timing: '9:00 AM – 4:30 PM',
      bestTimeToVisit: 'Early morning for best photos',
      latitude: 26.9239,
      longitude: 75.8267,
      address: 'Hawa Mahal Rd, Pink City, Jaipur, Rajasthan 302002',
      nearbyTransport: [
        '🚌 City Bus: Route 8, 20 (Badi Chaupar)',
        '🛺 Auto from railway station: ₹100',
        '🚲 Cycle rickshaw in Pink City: ₹30–50',
      ],
      travelTips: [
        'Best photographed from the opposite road café',
        'Morning light makes the sandstone glow',
        'Combine with City Palace visit',
        'Bargain at bazaars on the street',
      ],
      estimatedBudget: '₹200–400 per person',
      nearbyFood: [
        'Laxmi Mishthan Bhandar (LMB)',
        'Rawat Mishtan Bhandar',
        'Natraj Restaurant',
      ],
      nearbyHotels: [
        'Hotel Sarang Palace',
        'Umaid Bhawan',
        'Pearl Palace Heritage',
      ],
    ),

    TourismPlace(
      id: 'city_palace_jaipur',
      name: 'City Palace Jaipur',
      cityId: 'jaipur',
      category: 'heritage',
      description:
      'A sprawling royal complex blending Mughal and Rajput architecture at Jaipur\'s heart.',
      fullDescription:
      'The City Palace was the seat of the Maharaja of Jaipur. The complex includes the Chandra Mahal and Mubarak Mahal palaces. A large part is now a museum while the royal family still resides in a portion. The museum displays royal costumes, weapons, manuscripts, and paintings.',
      imageUrl: 'assets/images/jaipur.jpg',
      galleryImages: [
        'assets/images/jaipur.jpg',
      ],
      rating: 4.7,
      reviewCount: 55000,
      entryFee: '₹200 (Indian) / ₹700 (Foreign)',
      timing: '9:30 AM – 5:00 PM',
      bestTimeToVisit: 'Morning',
      latitude: 26.9258,
      longitude: 75.8237,
      address: 'Tulsi Marg, Pink City, Jaipur, Rajasthan 302002',
      nearbyTransport: [
        '🛺 Auto from Jaipur Junction: ₹80',
        '🚌 City Bus to Tripolia Bazar',
        '🚲 Cycle rickshaw: ₹30',
      ],
      travelTips: [
        'Combined ticket with Jantar Mantar available',
        'Photography fee is additional',
        'Attend the cultural show in evenings',
        'Royal Gaitor nearby for cenotaphs',
      ],
      estimatedBudget: '₹400–700 per person',
      nearbyFood: [
        '1135 AD Restaurant (inside palace)',
        'Peacock Rooftop Restaurant',
        'Anokhi Cafe',
      ],
      nearbyHotels: [
        'Jai Mahal Palace',
        'The Oberoi Rajvilas',
        'Samode Haveli',
      ],
    ),

    // ══════════════════════════════════════════════════════════════════════════
    // DELHI
    // ══════════════════════════════════════════════════════════════════════════

    TourismPlace(
      id: 'red_fort',
      name: 'Red Fort',
      cityId: 'delhi',
      category: 'heritage',
      description:
      'India\'s iconic Mughal fortress — where the PM addresses the nation on Independence Day.',
      fullDescription:
      'The Red Fort was the main residence of Mughal emperors for nearly 200 years. Located in the centre of Delhi, it houses several museums. Designated a UNESCO World Heritage Site in 2007, it was the ceremonial and political centre of Mughal government.',
      imageUrl: 'assets/images/delhi.jpg',
      galleryImages: [
        'assets/images/delhi.jpg',
      ],
      rating: 4.5,
      reviewCount: 120000,
      entryFee: '₹35 (Indian) / ₹500 (Foreign)',
      timing: '9:30 AM – 4:30 PM (Closed Monday)',
      bestTimeToVisit: 'October to March',
      latitude: 28.6562,
      longitude: 77.2410,
      address: 'Netaji Subhash Marg, Chandni Chowk, New Delhi 110006',
      nearbyTransport: [
        '🚇 Metro: Lal Qila (Red Line)',
        '🚌 Bus stop at Chandni Chowk',
        '🛺 Auto from Connaught Place: ₹100–150',
      ],
      travelTips: [
        'Book online for skip-the-line entry',
        'Evening Sound & Light show at 7:30 PM',
        'Combine with Chandni Chowk food tour',
      ],
      estimatedBudget: '₹300–600 per person',
      nearbyFood: [
        'Karim\'s Restaurant',
        'Natraj Dahi Bhalla',
        'Old Famous Jalebi Wala',
      ],
      nearbyHotels: [
        'Hotel Broadway',
        'Haveli Dharampura',
        'The Oberoi New Delhi',
      ],
    ),

    TourismPlace(
      id: 'qutub_minar',
      name: 'Qutub Minar',
      cityId: 'delhi',
      category: 'heritage',
      description:
      'World\'s tallest brick minaret — a 73-metre marvel of Indo-Islamic architecture from 1193 AD.',
      fullDescription:
      'Qutb Minar is a 72.5-metre tall tapering tower of five storeys, constructed from 1193 CE. The surrounding Qutb Complex contains the famous non-rusting Iron Pillar from the 4th century.',
      imageUrl: 'assets/images/delhi.jpg',
      galleryImages: [
        'assets/images/delhi.jpg',
      ],
      rating: 4.6,
      reviewCount: 95000,
      entryFee: '₹35 (Indian) / ₹550 (Foreign)',
      timing: '7:00 AM – 5:00 PM',
      bestTimeToVisit: 'Winter mornings',
      latitude: 28.5245,
      longitude: 77.1855,
      address: 'Mehrauli, New Delhi 110030',
      nearbyTransport: [
        '🚇 Metro: Qutab Minar (Yellow Line)',
        '🚌 Bus: Route 505, 534',
        '🛺 Auto from Saket: ₹60–80',
      ],
      travelTips: [
        'Explore the entire Qutb Complex',
        'Touch the Iron Pillar for good luck!',
        'Early morning is less crowded',
      ],
      estimatedBudget: '₹250–500 per person',
      nearbyFood: [
        'Dilli Haat (nearby)',
        'SodaBottleOpenerWala',
        'Hauz Khas Village cafes',
      ],
      nearbyHotels: [
        'JW Marriott Aerocity',
        'Holiday Inn Mayur Vihar',
        'Bloom Rooms',
      ],
    ),

    TourismPlace(
      id: 'india_gate',
      name: 'India Gate',
      cityId: 'delhi',
      category: 'attraction',
      description:
      'India\'s iconic war memorial — a majestic 42-metre arch dedicated to 82,000 soldiers.',
      fullDescription:
      'India Gate is a war memorial designed by Sir Edwin Lutyens on the Rajpath, commemorating 82,000 soldiers. The eternal flame of Amar Jawan Jyoti burns at its base.',
      imageUrl: 'assets/images/delhi.jpg',
      galleryImages: [
        'assets/images/delhi.jpg',
      ],
      rating: 4.7,
      reviewCount: 200000,
      entryFee: 'Free',
      timing: '24 hours (best after sunset)',
      bestTimeToVisit: 'Evening and nights',
      latitude: 28.6129,
      longitude: 77.2295,
      address: 'Rajpath Marg, India Gate, New Delhi 110001',
      nearbyTransport: [
        '🚇 Metro: Central Secretariat (Violet/Yellow)',
        '🚌 Bus: Multiple routes on Rajpath',
        '🛺 Auto from Khan Market: ₹60',
      ],
      travelTips: [
        'Evenings are spectacular with illumination',
        'Surrounding lawns perfect for picnics',
      ],
      estimatedBudget: '₹100–200 (food + transport)',
      nearbyFood: [
        'India Gate chaat stalls',
        'Cafe Lota at Crafts Museum',
        'Khan Market cafes',
      ],
      nearbyHotels: [
        'The Imperial Hotel',
        'Le Meridien New Delhi',
        'Shangri-La New Delhi',
      ],
    ),

    // ══════════════════════════════════════════════════════════════════════════
    // VARANASI
    // ══════════════════════════════════════════════════════════════════════════

    TourismPlace(
      id: 'kashi_vishwanath',
      name: 'Kashi Vishwanath Temple',
      cityId: 'varanasi',
      category: 'heritage',
      description:
      'One of the holiest Hindu temples — dedicated to Lord Shiva in the divine city of Kashi.',
      fullDescription:
      'The Kashi Vishwanath Temple is one of the most famous temples dedicated to Lord Shiva, on the western bank of the Ganga. It is one of the twelve Jyotirlingas. The gold-plated spire weighs approximately 820 kg of gold donated by Maharaja Ranjit Singh.',
      imageUrl: 'assets/images/varanasi.jpg',
      galleryImages: [
        'assets/images/varanasi.jpg',
      ],
      rating: 4.9,
      reviewCount: 75000,
      entryFee: 'Free (Prasad: ₹50)',
      timing: '3:00 AM – 11:00 PM',
      bestTimeToVisit: 'Early morning for aarti',
      latitude: 25.3109,
      longitude: 83.0107,
      address: 'Lahori Tola, Varanasi, Uttar Pradesh 221001',
      nearbyTransport: [
        '🛺 E-rickshaw from Godaulia: ₹20–30',
        '🚶 Walking through ghats (recommended)',
        '🚌 Bus from Varanasi Junction: ₹15',
      ],
      travelTips: [
        'Arrive 30 min before morning aarti at 3 AM',
        'Dress modestly (cover head)',
        'Mobile phones not allowed inside',
      ],
      estimatedBudget: '₹200–500 per person',
      nearbyFood: [
        'Blue Lassi Shop',
        'Deena Chaat Bhandar',
        'Kashi Chat Bhandar',
      ],
      nearbyHotels: [
        'Hotel Ganges View',
        'BrijRama Palace',
        'Ramada Plaza Varanasi',
      ],
    ),

    TourismPlace(
      id: 'dashashwamedh_ghat',
      name: 'Dashashwamedh Ghat',
      cityId: 'varanasi',
      category: 'heritage',
      description:
      'The main ghat of Varanasi — host to the spectacular Ganga Aarti every evening.',
      fullDescription:
      'Dashashwamedh Ghat is the main and most spectacular ghat in Varanasi on the Ganges. Every evening at dusk, an elaborate Ganga Aarti ceremony with fire, flowers, and chanting attracts thousands of pilgrims and tourists from around the world.',
      imageUrl: 'assets/images/varanasi.jpg',
      galleryImages: [
        'assets/images/varanasi.jpg',
      ],
      rating: 4.8,
      reviewCount: 95000,
      entryFee: 'Free (Boat: ₹200–500)',
      timing: '5:00 AM – 10:00 PM',
      bestTimeToVisit: 'Evening (6:30–7:30 PM for Aarti)',
      latitude: 25.3070,
      longitude: 83.0110,
      address: 'Dashashwamedh Rd, Varanasi, Uttar Pradesh 221001',
      nearbyTransport: [
        '🛥️ Boat ride along ghats: ₹200–500',
        '🛺 E-rickshaw from center: ₹20–30',
        '🚶 Walking from Vishwanath Temple: 5 min',
      ],
      travelTips: [
        'Book a boat for best Aarti viewing',
        'Arrive 45 minutes early for a good spot',
        'Float a diya (lamp) on the Ganga',
      ],
      estimatedBudget: '₹300–700 per person',
      nearbyFood: [
        'Bread of Life Bakery',
        'Vishwanath Gali snacks',
        'Ramna Cold Lassi',
      ],
      nearbyHotels: [
        'Ganpati Guest House',
        'Alka Hotel',
        'Hotel Surya',
      ],
    ),
  ];

  // ─── Quick Prompts for AI Chat ────────────────────────────────────────────
  static const List<String> quickPrompts = [
    '🗺️ Plan a 2-day Kolkata trip under ₹3000',
    '🚌 Cheap transport in Kolkata for tourists',
    '🏨 Best budget hotels near Howrah',
    '🏛️ Hidden heritage places in Kolkata',
    '🍛 Best street food in Kolkata',
    '💰 Budget itinerary for Kolkata in 3 days',
    '🚂 How to travel cheaply within Kolkata',
    '📸 Best photography spots in Kolkata',
  ];

  // ─── Helper Methods ───────────────────────────────────────────────────────

  static List<TourismPlace> getPlacesByCity(String cityId) =>
      places.where((p) => p.cityId == cityId).toList();

  static List<TourismPlace> getPlacesByCategory(
      String cityId, String category) =>
      places.where((p) => p.cityId == cityId && p.category == category).toList();

  static TourismPlace? getPlaceById(String id) =>
      places.where((p) => p.id == id).firstOrNull;

  static City? getCityById(String id) =>
      cities.where((c) => c.id == id).firstOrNull;

  /// Featured = top-rated Kolkata places first, then others
  static List<TourismPlace> getFeaturedPlaces() {
    final kolkata = places
        .where((p) => p.cityId == 'kolkata' && p.rating >= 4.4)
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    return kolkata.take(6).toList();
  }

  /// Only Kolkata is active; others show coming soon
  static bool isCityActive(String cityId) => cityId == 'kolkata';
}