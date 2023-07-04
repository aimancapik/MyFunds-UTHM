import 'package:flutter/material.dart';

class FeaturedCampaignWidget extends StatelessWidget {
  final String campaignTitle;
  final String fundsTarget;
  final String approved;
  final String imageLink;

  FeaturedCampaignWidget({
    required this.campaignTitle,
    required this.fundsTarget,
    required this.approved,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campaignTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Funds Target: $fundsTarget',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Approved: $approved',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16),
          Image.network(
            imageLink,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
