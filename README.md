# Bubble Shooter

### Implementação do Jogo Bubble Shooter

A realização do projeto foi feita para a disciplina Paradigmas de Linguagem de Programação.

Clone o repositório

```bash
$ git clone https://github.com/davihsg/bubble-shooter.git
```

Entre no repositório

```bash
$ cd bubble-shooter
```

### Para a funcionalidade da aplicação em Haskell é necessário

- Ter em sua máquina [haskell , Cabal e GHC](https://www.haskell.org/downloads/).
- Ter em sua máquina o Haskell plataform funcionando :

    ```bash
    $ sudo apt-get install haskell-platform
    ```

- Tenha um display de dimensões maiores ou iguais há 700 de altura e 700 de largura.

Em primeiro lugar, é preciso que se instale o cabal executável :

```bash
$ cabal update
$ cabal install Cabal cabal-install
```

Após isso é necessário a lib `gloss` do `cabal` que pode ser obtida utilizando:

```bash
$ cabal install gloss
```

Agora será necessário entrar no diretório Haskell:

```bash
$ cd haskell
```

Por fim para rodar o jogo e instalar as dependências faltantes execute:

```bash
$ cabal run
```

Assim será aberta uma interface gráfica que permitirá o acesso ao jogo :

![Hnet-image(2)(1)](https://user-images.githubusercontent.com/84549704/156785878-bd6176ad-6795-4b9d-be4f-014574ac0998.gif)

# Autores

- Davi Henrique ([davihsg](https://github.com/davihsg))
- Abraão Caiana ([AbraaoCF](https://github.com/AbraaoCF))
- Júlia Oliveira ([juliaokmenezes](https://github.com/juliaokmenezes))
- João Matheus ([joaoduavy](https://github.com/joaoduavy))
- Maria Luiza ([mluizamarinho](https://github.com/mluizamarinho))
