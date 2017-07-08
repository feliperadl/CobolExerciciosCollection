       IDENTIFICATION DIVISION.
       PROGRAM-ID.  Questao2.
       AUTHOR.  Felipe.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQENTFILE ASSIGN TO "ARQENT.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ARQAPROFILE ASSIGN TO "ARQAPRO.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ARQREPROFILE ASSIGN TO "ARQREPRO.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ARQEXAMEFILE ASSIGN TO "ARQEXAME.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
           FD ARQENTFILE.
               01 ARQENT.
                   02  CODIGO        PIC 9(5).
                   02  NOME          PIC X(10).
                   02  TURMA         PIC X(10).
                   02  NOTA1         PIC 9(2)V9(2).
                   02  NOTA2         PIC 9(2)V9(2).
           FD ARQAPROFILE.
               01 ARQAPRO.
                   02  ACODIGO        PIC 9(5).
                   02  ANOME          PIC X(10).
                   02  AMEDIA         PIC 9(2)V9(2).
           FD ARQREPROFILE.
               01 ARQAREPRO.
                   02  RCODIGO        PIC 9(5).
                   02  RNOME          PIC X(10).
                   02  RMEDIA_EXAME   PIC 9(2)V9(2).
           FD ARQEXAMEFILE.
               01 ARQAEXAME.
                   02  ECODIGO        PIC 9(5).
                   02  ENOME          PIC X(10).
                   02  ETURMA         PIC X(10).


       WORKING-STORAGE SECTION.
           01 MEDIA_CAL PIC 9(2)V9(2) VALUE ZERO.

       PROCEDURE DIVISION.
       Begin.
           OPEN OUTPUT ARQEXAMEFILE
           OPEN OUTPUT ARQREPROFILE
           OPEN OUTPUT ARQAPROFILE
           OPEN INPUT ARQENTFILE
           READ ARQENTFILE
              AT END MOVE HIGH-VALUES TO ARQENT
           END-READ
           PERFORM MovimentacaoFile UNTIL ARQENT = HIGH-VALUES
           CLOSE ARQEXAMEFILE
           CLOSE ARQREPROFILE
           CLOSE ARQAPROFILE
           CLOSE ARQENTFILE
           STOP RUN.

       MovimentacaoFile.
           COMPUTE MEDIA_CAL = (NOTA1 + NOTA2) / 2
           EVALUATE  MEDIA_CAL
           WHEN > 5
               MOVE CODIGO  TO ACODIGO
               MOVE NOME  TO ANOME
               MOVE MEDIA_CAL TO AMEDIA
               WRITE ARQAPRO
           WHEN  < 3
               MOVE CODIGO    TO RCODIGO
               MOVE NOME      TO RNOME
               MOVE MEDIA_CAL TO RMEDIA_EXAME
               WRITE ARQAREPRO
          WHEN OTHER
               MOVE CODIGO    TO ECODIGO
               MOVE NOME      TO ENOME
               MOVE TURMA     TO ETURMA
               WRITE ARQAEXAME
           END-EVALUATE


           READ ARQENTFILE
               AT END MOVE HIGH-VALUES TO ARQENT
           END-READ
