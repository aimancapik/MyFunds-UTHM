class Campaign {
  final String name;
  final String assetName;

  Campaign({required this.name, required this.assetName});
}
//jenis campaign

List<Campaign> campaign= [
  Campaign(
    name: 'Education',
    assetName: 'assets/images/grad.png',
  ),
  Campaign(
    name: 'Health',
    assetName: 'assets/images/medic.png',
  ),
  Campaign(
    name: 'Environment',
    assetName: 'assets/images/env.png',
  ),
  Campaign(
    name: 'Emergency Relief',
    assetName: 'assets/images/kecemasan.png',
  ),
  Campaign(
    name: 'Culture & Arts',
    assetName: 'assets/images/event.png',
  ),
];
