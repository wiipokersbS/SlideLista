class User {
  final String? nome;
  final String? email;
  final String? image;

  User({this.nome, this.email, this.image});
}

final allUsers = [
  User(
      nome: 'Ana Silva',
      email: 'ana.silva@teste.com.br',
      image:
          'https://img.freepik.com/fotos-premium/foto-de-rosto-de-mulher-jovem-latina-feliz-com-fundo-de-expressao-de-sorriso-com-espaco-de-copia-retrato-de-rosto-de-pessoas-reais-etnicas-da-america-do-sul-boliviana_394926-96.jpg'),
  User(
      nome: 'Lucas Souza',
      email: 'lucas.souza@teste.com.br',
      image:
          'https://i.pinimg.com/736x/fd/fc/ef/fdfcefc24e58a4e3ed4dd6099d530353.jpg'),
  User(
      nome: 'Marina Souza',
      email: 'marina.souza@teste.com.br',
      image:
          'https://img.r7.com/images/rosto-humano-irreal-inteligencia-artificial-19022019142837145?dimensions=1024x1024'),
];
