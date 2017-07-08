       IDENTIFICATION DIVISION.
       PROGRAM-ID.  Questao1.
       AUTHOR.  Felipe.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQENTFILE ASSIGN TO "ARQENT.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ARQSAIFILE ASSIGN TO "ARQSAI.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
           FD ARQENTFILE.
               01 ARQENT.
                   02  CODIGO       PIC 9(5).
                   02  NOME         PIC X(10).
                   02  CARGO        PIC X(10).
                   02  DEPTO        PIC X(10).
                   02  SALARIO      PIC 9(5)V9(2) VALUE ZERO.
           FD ARQSAIFILE.
               01 ARQSAI.
                   02  SCODIGO       PIC 9(5).
                   02  SNOME         PIC X(10).
                   02  SCARGO        PIC X(10).
                   02  SSALARIO      PIC 9(5)V9(2) VALUE ZERO.
       WORKING-STORAGE SECTION.
           01 SALARIO_30 PIC 9(5)V9(2) VALUE ZERO.
           01 SALARIO_20 PIC 9(5)V9(2) VALUE ZERO.

       PROCEDURE DIVISION.
       Begin.
           OPEN OUTPUT ARQSAIFILE
           OPEN INPUT ARQENTFILE
           READ ARQENTFILE
              AT END MOVE HIGH-VALUES TO ARQENT
           END-READ
           PERFORM MovimentacaoFile UNTIL ARQENT = HIGH-VALUES
           CLOSE ARQSAIFILE
           CLOSE ARQENTFILE
           STOP RUN.

       MovimentacaoFile.
           COMPUTE SALARIO_30 = SALARIO * 1.30
           COMPUTE SALARIO_20 = SALARIO * 1.20
           IF SALARIO_30 < 05000.00 OR SALARIO_20 > 10000.00 THEN
               MOVE CODIGO  TO SCODIGO
               MOVE NOME  TO SNOME
               MOVE CARGO TO SCARGO
               MOVE SALARIO TO SSALARIO
               WRITE ARQSAI
           END-IF

           READ ARQENTFILE
               AT END MOVE HIGH-VALUES TO ARQENT
           END-READ
