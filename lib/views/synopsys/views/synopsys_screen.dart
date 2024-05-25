import 'package:flutter/material.dart';

class SynopsysScreen extends StatefulWidget {
  @override
  _SynopsysScreenState createState() => _SynopsysScreenState();
}

class _SynopsysScreenState extends State<SynopsysScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Synopsys Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCurrencyContainer('USD', 'EUR', 0.92),
            SizedBox(height: 20),
            _buildCurrencyContainer('USDT', 'USD', 1.0),
            SizedBox(height: 10),
            _buildCurrencyContainer('Bitcoin', 'USD', 48000),
            SizedBox(height: 10),
            _buildCurrencyContainer('Ethereum', 'USD', 3200),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyContainer(
      String baseCurrency, String targetCurrency, double rate) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('1 $baseCurrency = $rate $targetCurrency'),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Currency Conversion'),
                  content:
                      Text('1 $targetCurrency = ${1 / rate} $baseCurrency'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
            child: Icon(Icons.info, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
