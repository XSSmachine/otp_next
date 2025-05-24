import 'package:flutter/material.dart';

class TicketMasterScreen extends StatefulWidget {
  const TicketMasterScreen({Key? key}) : super(key: key);

  @override
  State<TicketMasterScreen> createState() => _TicketMasterScreenState();
}

class _TicketMasterScreenState extends State<TicketMasterScreen> {
  String? selectedCategory;

  final List<TicketCategory> categories = [
    TicketCategory(
      id: 'account_services',
      title: 'Rad po računu',
      icon: Icons.account_balance_wallet_outlined,
      description: 'Otvaranje računa, zatvaranje, promjene',
    ),
    TicketCategory(
      id: 'cash_loans',
      title: 'Gotovinski krediti',
      icon: Icons.payments_outlined,
      description: 'Gotovinski krediti i refinanciranje',
    ),
    TicketCategory(
      id: 'housing_loans',
      title: 'Stambeni krediti',
      icon: Icons.home_outlined,
      description: 'Stambeni krediti i hipoteke',
    ),
    TicketCategory(
      id: 'cards',
      title: 'Kartice',
      icon: Icons.credit_card_outlined,
      description: 'Izdavanje i upravljanje karticama',
    ),
    TicketCategory(
      id: 'savings_deposits',
      title: 'Štedni računi i oročavanje',
      icon: Icons.savings_outlined,
      description: 'Štedni proizvodi i oročavanje',
    ),
    TicketCategory(
      id: 'business_banking',
      title: 'Poslovno bankarstvo',
      icon: Icons.business_outlined,
      description: 'Usluge za pravne osobe',
    ),
    TicketCategory(
      id: 'investment',
      title: 'Investicijski proizvodi',
      icon: Icons.trending_up_outlined,
      description: 'Fondovi, obveznice, investiranje',
    ),
    TicketCategory(
      id: 'insurance',
      title: 'Osiguranje',
      icon: Icons.security_outlined,
      description: 'Životno i neživotno osiguranje',
    ),
    TicketCategory(
      id: 'foreign_currency',
      title: 'Devizno poslovanje',
      icon: Icons.currency_exchange_outlined,
      description: 'Devizni računi i transakcije',
    ),
    TicketCategory(
      id: 'digital_banking',
      title: 'Digitalno bankarstvo',
      icon: Icons.smartphone_outlined,
      description: 'Mobilno i internet bankarstvo',
    ),
    TicketCategory(
      id: 'complaints',
      title: 'Pritužbe i reklamacije',
      icon: Icons.report_problem_outlined,
      description: 'Rješavanje pritužbi i problema',
    ),
    TicketCategory(
      id: 'other',
      title: 'Ostalo',
      icon: Icons.help_outline,
      description: 'Ostale bankarske usluge',
    ),
  ];

  void _onCategorySelected(TicketCategory category) {
    setState(() {
      selectedCategory = category.id;
    });

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Text(
          'Odabrana kategorija',
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.title,
              style: const TextStyle(
                color: Color(0xFF7ED957),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.description,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text(
              'Molimo sačekajte da vas pozovemo...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                selectedCategory = null;
              });
            },
            child: const Text(
              'Odustani',
              style: TextStyle(color: Color(0xFF7ED957)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _generateTicket(category);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7ED957),
              foregroundColor: Colors.black,
            ),
            child: const Text('Potvrdi'),
          ),
        ],
      ),
    );
  }

  void _generateTicket(TicketCategory category) {
    // Simulate ticket generation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Karta generirana',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF7ED957),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Broj karte: ${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
              style: const TextStyle(
                color: Color(0xFF7ED957),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Kategorija: ${category.title}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Molimo sačekajte da vas pozovemo na šalter.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                selectedCategory = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7ED957),
              foregroundColor: Colors.black,
            ),
            child: const Text('U redu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        title: const Text(
          'Uzmi broj',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF7ED957)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header instruction
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF7ED957),
                width: 1,
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.touch_app_outlined,
                  color: Color(0xFF7ED957),
                  size: 32,
                ),
                SizedBox(height: 8),
                Text(
                  'Odaberite kategoriju usluge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dodirnite kategoriju za koju trebate pomoć',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Categories grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category.id;

                  return GestureDetector(
                    onTap: () => _onCategorySelected(category),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF7ED957).withOpacity(0.1)
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF7ED957)
                              : const Color(0xFF3A3A3A),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: const Color(0xFF7ED957).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : [],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category.icon,
                              color: isSelected
                                  ? const Color(0xFF7ED957)
                                  : Colors.white70,
                              size: 32,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              category.title,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF7ED957)
                                    : Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.description,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF7ED957).withOpacity(0.8)
                                    : Colors.white60,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF7ED957),
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Nakon odabira kategorije, dobit ćete broj karte. Molimo sačekajte da vas pozovemo.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TicketCategory {
  final String id;
  final String title;
  final IconData icon;
  final String description;

  const TicketCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
  });
}