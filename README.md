# Recruiter API

Recruiter API é uma aplicação construída em Ruby on Rails que fornece endpoints para gerenciar recrutadores e seus processos de autenticação. Além disso, a API permite gerenciar vagas de emprego (jobs) e submissões de candidatos.

## Requisitos

- Ruby 2.7.2
- Rails 6.0.0
- PostgreSQL

## Endpoints

### Autenticação

- `POST /api/v1/recruiter/recruiters/login` - Autenticar um recrutador e obter um token JWT.

### Recrutadores

- `GET /api/v1/recruiter/recruiters` - Listar todos os recrutadores.
- `GET /api/v1/recruiter/recruiters/:id` - Obter detalhes de um recrutador específico.
- `POST /api/v1/recruiter/recruiters` - Criar um novo recrutador.
- `PUT /api/v1/recruiter/recruiters/:id` - Atualizar um recrutador existente.
- `DELETE /api/v1/recruiter/recruiters/:id` - Excluir um recrutador.

### Vagas (Jobs)

- `GET /api/v1/recruiter/jobs` - Listar todas as vagas.
- `POST /api/v1/recruiter/jobs` - Criar uma nova vaga.
- `GET /api/v1/recruiter/jobs/:id` - Obter detalhes de uma vaga específica.
- `PUT /api/v1/recruiter/jobs/:id` - Atualizar uma vaga existente.
- `DELETE /api/v1/recruiter/jobs/:id` - Excluir uma vaga.

### Submissões

- `GET /api/v1/recruiter/jobs/:job_id/submissions` - Listar todas as submissões para uma vaga específica.
- `POST /api/v1/recruiter/jobs/:job_id/submissions` - Criar uma nova submissão para uma vaga específica.
- `GET /api/v1/recruiter/submissions/:id` - Obter detalhes de uma submissão específica.
- `PUT /api/v1/recruiter/submissions/:id` - Atualizar uma submissão existente.
- `DELETE /api/v1/recruiter/submissions/:id` - Excluir uma submissão.

## Autenticação

A API usa JWT (JSON Web Tokens) para autenticação. Para acessar os endpoints protegidos, inclua o token JWT no cabeçalho da requisição:

