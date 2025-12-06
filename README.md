# Amiibo Gallery

Um aplicativo Flutter para visualização e coleção de Amiibos da Nintendo.

## 📱 Funcionalidades

- **Sistema de Login Local**: Cadastro e login de usuários armazenados localmente
- **Galeria de Amiibos**: Visualização de todos os Amiibos disponíveis via API
- **Sistema de Favoritos**: Adicione Amiibos à sua coleção pessoal
- **Busca de Amiibos**: Pesquise Amiibos por nome
- **Interface Temática**: Design inspirado no tema Nintendo

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento
- **GetX**: Gerenciamento de estado e navegação
- **Hive**: Banco de dados local NoSQL
- **HTTP**: Requisições para API externa
- **AmiiboAPI**: API pública dos Amiibos Nintendo

## Estrutura do Projeto

```
lib/
├── controllers/     # Controladores GetX
├── models/         # Modelos de dados
├── screens/        # Telas do aplicativo
├── services/       # Serviços (API)
├── widgets/        # Widgets reutilizáveis
└── main.dart       # Ponto de entrada
```

## 🚀 Como Executar

1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/amiibo-gallery.git
```

2. Entre na pasta do projeto
```bash
cd amiibo-gallery
```

3. Instale as dependências
```bash
flutter pub get
```

4. Gere os arquivos do Hive
```bash
flutter packages pub run build_runner build
```

5. Execute o aplicativo
```bash
flutter run
```

## Funcionalidades por Tela

### Tela de Login
- Login com usuário e senha
- Link para cadastro

### Tela de Cadastro
- Criação de nova conta
- Validação de senhas

### Tela Principal (Home)
- Grid com todos os Amiibos disponíveis
- Barra de pesquisa
- Botão de favoritar em cada Amiibo
- Informações da série do jogo
- Imagens oficiais dos Amiibos

### Tela de Favoritos (Minha Coleção)
- Visualização dos Amiibos favoritados
- Mesmo layout da tela principal

## 🌐 API Utilizada

- **AmiiboAPI**: https://www.amiiboapi.com/api/amiibo/
- Dados públicos e gratuitos dos Amiibos Nintendo

## 📸 Screenshots

| Tela de Login | Tela Principal | Tela de Favoritos |
|---------------|----------------|-------------------|
| ![Login](screenshots/login.png) | ![Home](screenshots/home.png) | ![Favoritos](screenshots/favorites.png) |

## 📝 Requisitos

- Flutter SDK (versão 3.9.2 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

## 🎯 Funcionalidades Implementadas

- [x] Sistema de autenticação local
- [x] Consumo de API REST
- [x] Gerenciamento de estado com GetX
- [x] Persistência local com Hive
- [x] Sistema de favoritos
- [x] Interface responsiva
- [x] Busca e filtragem

## 👥 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📞 Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - seu.email@exemplo.com

Link do Projeto: [https://github.com/seu-usuario/amiibo-gallery](https://github.com/seu-usuario/amiibo-gallery)
