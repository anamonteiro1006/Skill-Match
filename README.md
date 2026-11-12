<div align="center">

# 💜 SkillMatch
### Transformando habilidades em oportunidades!

**Plataforma de Capacitação e Oportunidades para Freelancers**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design](https://img.shields.io/badge/Material_3-6750A4?style=for-the-badge&logo=materialdesign&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

**🎓 Universidade de Mogi das Cruzes — UMC**

---

</div>

## 📖 Sobre o projeto

O **SkillMatch** é um aplicativo acadêmico desenvolvido com **Flutter e Dart**, criado para aproximar freelancers, especialmente profissionais iniciantes, de oportunidades de trabalho.

A plataforma busca facilitar a conexão entre profissionais e clientes, oferecendo funcionalidades que auxiliam na divulgação de habilidades, na busca por oportunidades e no desenvolvimento profissional.

O aplicativo possui dois tipos de conta:

- 👩‍💻 **Freelancer:** pode explorar oportunidades, enviar propostas, acompanhar candidaturas e organizar seu perfil profissional.
- 💼 **Cliente:** pode publicar oportunidades, visualizar propostas e gerenciar suas publicações.

Além disso, o SkillMatch apresenta catálogo de cursos, portfólio profissional, notificações e navegação entre diferentes áreas da plataforma.

## 🎯 Objetivos

- Facilitar o acesso de freelancers iniciantes ao mercado de trabalho.
- Conectar profissionais e clientes em uma única plataforma.
- Incentivar a capacitação e o desenvolvimento de habilidades.
- Proporcionar maior visibilidade aos profissionais.
- Simplificar a publicação de oportunidades e o envio de propostas.
- Aplicar os conhecimentos adquiridos durante a disciplina de Desenvolvimento de Aplicativos em Flutter.

---

## ✨ Funcionalidades

### 👩‍💻 Área do Freelancer

- Cadastro e acesso ao aplicativo.
- Visualização e edição do perfil.
- Busca de oportunidades disponíveis.
- Visualização dos detalhes de cada oportunidade.
- Envio e acompanhamento de propostas.
- Consulta ao catálogo de cursos.
- Gerenciamento do portfólio profissional.
- Acesso às notificações.

### 💼 Área do Cliente

- Cadastro e acesso ao aplicativo.
- Visualização do perfil.
- Publicação de oportunidades.
- Gerenciamento das oportunidades publicadas.
- Visualização de propostas recebidas.
- Exclusão de oportunidades.

### 🧭 Navegação principal

O aplicativo possui uma barra de navegação com quatro seções:

| Seção | Funcionalidade |
|---|---|
| 🏠 Início | Página inicial personalizada conforme o tipo de conta |
| 🔎 Buscar | Pesquisa de oportunidades e profissionais |
| 📚 Cursos | Catálogo de cursos e conteúdos de capacitação |
| 👤 Perfil | Informações pessoais, habilidades e portfólio |

---

## 🛠️ Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| **Flutter** | Desenvolvimento das interfaces e funcionalidades |
| **Dart** | Linguagem de programação |
| **Material Design 3** | Componentes e identidade visual |
| **SharedPreferences** | Persistência local de informações |
| **JSON** | Estruturação dos dados armazenados |
| **Google Chrome** | Execução e testes da versão web |
| **Poppins** | Tipografia utilizada no aplicativo |
| **Git e GitHub** | Versionamento e compartilhamento do código |
| **Visual Studio Code** | Ambiente de desenvolvimento |

---

## 📂 Estrutura do projeto

O código foi organizado em diretórios para facilitar a identificação dos componentes e a manutenção do aplicativo.

```text
skill_match/
│
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── data/
│   ├── theme/
│   ├── view/
│   └── controller/
│
├── assets/
│   ├── img/
│   └── fonts/
│
├── android/
├── ios/
├── web/
│
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

### 📁 Organização dos diretórios

| Diretório | Responsabilidade |
|---|---|
| `lib/main.dart` | Fluxo de telas e lógica de interação da demonstração |
| `lib/models/` | Modelos de oportunidades e propostas |
| `lib/data/` | Dados iniciais utilizados na demonstração |
| `lib/theme/` | Cores e configurações visuais compartilhadas |
| `lib/view/` | Componentes e arquivos de interface |
| `lib/controller/` | Arquivos de apoio ao controle das interações |
| `assets/` | Logotipo, imagens e fontes |

---

## 🚀 Como executar o projeto

### Pré-requisitos

Antes de executar o aplicativo, é necessário ter instalado:

- Flutter SDK.
- Visual Studio Code ou outro editor compatível.
- Google Chrome.
- Git, caso deseje clonar o repositório.

### 1. Verificar a instalação do Flutter

Abra o terminal e execute:

```bash
flutter doctor
```

### 2. Clonar o repositório

```bash
git clone https://github.com/anamonteiro1006/skillmatch.git
```

### 3. Acessar a pasta do projeto

```bash
cd skillmatch
```

### 4. Instalar as dependências

```bash
flutter pub get
```

### 5. Executar o aplicativo

```bash
flutter run -d chrome
```

O aplicativo será iniciado no navegador Google Chrome.

### 6. Verificar a qualidade do código

```bash
flutter analyze
```

Esse comando verifica possíveis problemas identificados pela análise estática do Dart e Flutter.

---

## 💾 Persistência local de dados

O SkillMatch utiliza o pacote **`shared_preferences`** para armazenar informações localmente no dispositivo ou navegador.

Os dados são organizados em formato JSON, permitindo que determinadas informações sejam recuperadas após o fechamento e a reabertura do aplicativo.

### Informações armazenadas

- Dados do perfil.
- Oportunidades publicadas.
- Propostas enviadas e recebidas.

### Funcionamento

1. O usuário realiza uma ação, como publicar uma oportunidade.
2. O aplicativo atualiza os dados locais.
3. As informações são armazenadas utilizando `shared_preferences`.
4. Ao abrir novamente o aplicativo, os dados salvos são carregados.

### ⚠️ Limitações do armazenamento

- Não utiliza banco de dados SQL.
- Não sincroniza informações entre dispositivos.
- Não é indicado para grandes volumes de dados.
- Não substitui um sistema de autenticação.
- As senhas não são persistidas.

Para uma versão destinada a usuários reais, seria necessário integrar serviços de autenticação e armazenamento em servidor, como Firebase Authentication e Cloud Firestore.

---

## 🧪 Testes e validações

Foram definidos os seguintes fluxos para verificar o funcionamento das principais funcionalidades.

### ✅ Cadastro e navegação

- [x] Acessar a tela de boas-vindas.
- [x] Realizar cadastro ou acessar o formulário de login.
- [x] Selecionar o tipo de conta.
- [x] Navegar entre Início, Buscar, Cursos e Perfil.

### ✅ Fluxo do Freelancer

- [x] Acessar a área de oportunidades.
- [x] Visualizar os detalhes de uma oportunidade.
- [x] Enviar uma proposta.
- [x] Consultar as propostas enviadas.
- [x] Acessar cursos e portfólio.

### ✅ Fluxo do Cliente

- [x] Publicar uma oportunidade.
- [x] Consultar as oportunidades publicadas.
- [x] Visualizar propostas recebidas.
- [x] Excluir uma oportunidade.

### ✅ Persistência local

- [x] Publicar uma oportunidade e verificar seu armazenamento.
- [x] Recarregar o aplicativo e verificar os dados.
- [x] Excluir uma oportunidade.
- [x] Enviar uma proposta e verificar sua permanência.

### Análise estática

Comando utilizado:

```bash
flutter analyze
```

Resultado obtido na verificação:

```text
No issues found!
```

---

## 🔄 Fluxo de utilização

### 👩‍💻 Jornada do Freelancer

**Boas-vindas → Cadastro/Login → Freelancer → Início → Buscar oportunidades → Detalhes → Enviar proposta → Minhas propostas**

O freelancer também pode acessar cursos, editar seu perfil e organizar seu portfólio.

### 💼 Jornada do Cliente

**Boas-vindas → Cadastro/Login → Cliente → Início → Publicar oportunidade → Minhas oportunidades → Propostas recebidas**

O cliente também pode visualizar e excluir oportunidades publicadas.

---

## 📸 Capturas de tela

As capturas reais do aplicativo podem ser adicionadas nesta seção para demonstrar visualmente suas funcionalidades.

| Tela | Descrição |
|---|---|
| 💜 Boas-vindas | Apresentação inicial do SkillMatch |
| 🔐 Login | Acesso ao aplicativo |
| 📝 Cadastro | Criação de conta |
| 👩‍💻 Início Freelancer | Página inicial do profissional |
| 💼 Início Cliente | Página inicial do cliente |
| 🔎 Oportunidades | Listagem de oportunidades |
| 📚 Cursos | Catálogo de capacitação |
| 👤 Perfil | Informações do usuário |

---

## ⚠️ Limitações conhecidas

O SkillMatch é um **protótipo acadêmico funcional**, desenvolvido para demonstrar os principais fluxos de interação entre freelancers e clientes.

Algumas funcionalidades ainda possuem limitações:

- O login não está integrado a um provedor externo de autenticação.
- A recuperação e a alteração de senha possuem caráter demonstrativo.
- Os dados são armazenados localmente.
- Não existe sincronização entre dispositivos.
- O aplicativo não deve ser utilizado com credenciais reais.

Essas limitações poderão ser tratadas em futuras versões da plataforma.

---

## 🔮 Melhorias futuras

Entre as possíveis evoluções do SkillMatch estão:

- Implementação de autenticação segura.
- Integração com banco de dados em nuvem.
- Sincronização de informações entre dispositivos.
- Ampliação das funcionalidades de cursos e capacitação.
- Melhorias na comunicação entre clientes e freelancers.
- Publicação de uma versão para dispositivos móveis.

---

## 👥 Equipe de desenvolvimento

O projeto foi desenvolvido por estudantes da **Universidade de Mogi das Cruzes (UMC)**.

| Integrante | Participação |
|---|---|
| **Ana Júlia Monteiro Lemes** | Desenvolvimento colaborativo do aplicativo |
| **Júlio Félix Quintero de Assis** | Desenvolvimento colaborativo do aplicativo |
| **Thamiris Bernal Molina** | Desenvolvimento colaborativo do aplicativo |

### 🤝 Colaboração

Os três integrantes participaram do desenvolvimento do código e da construção do SkillMatch.

As atividades envolveram a implementação de funcionalidades, organização das telas, testes, identificação de problemas e realização de melhorias.

A publicação inicial dos arquivos no GitHub foi centralizada em uma conta, embora o desenvolvimento tenha sido realizado em equipe.

---

## 🌎 Impacto social

O SkillMatch também está alinhado a dois Objetivos de Desenvolvimento Sustentável da Organização das Nações Unidas.

**ODS 8 — Trabalho Decente e Crescimento Econômico**

Incentivar o desenvolvimento profissional e ampliar o acesso a oportunidades de trabalho.

**ODS 10 — Redução das Desigualdades**

Contribuir para a inclusão de profissionais iniciantes, facilitando sua entrada no mercado.

---

## 📚 Considerações finais

O desenvolvimento do SkillMatch possibilitou a aplicação prática dos conhecimentos adquiridos em Flutter e Dart, envolvendo criação de interfaces, navegação, organização de código, manipulação de dados e persistência local.

O projeto demonstra como a tecnologia pode contribuir para aproximar profissionais e clientes, além de incentivar a capacitação e o desenvolvimento de novas habilidades.

Embora ainda existam possibilidades de evolução, o aplicativo apresenta os principais fluxos propostos para a atividade acadêmica.

---

<div align="center">

### 💜 SkillMatch
**Transformando habilidades em oportunidades!**

Desenvolvido com Flutter e Dart.

**Universidade de Mogi das Cruzes — UMC**

</div>
