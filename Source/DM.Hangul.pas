unit DM.Hangul;

interface

uses
  System.Sysutils,
  System.Classes,
  System.Generics.Collections;

type
  THangul = record
  strict private
  {$REGION 'define'}
    type
      TLetter = record
        Korean: string;
        English: string;
      end;
    const
      HANGUL_FIRST = $AC00;
      HANGUL_LAST = $D7A3;

      FIRST_LETTERS: array[0..18] of TLetter = (
        (Korean: '��'; English: 'G'),
        (Korean: '��'; English: 'GG'),
        (Korean: '��'; English: 'N'),
        (Korean: '��'; English: 'D'),
        (Korean: '��'; English: 'DD'),
        (Korean: '��'; English: 'R'),
        (Korean: '��'; English: 'M'),
        (Korean: '��'; English: 'B'),
        (Korean: '��'; English: 'BB'),
        (Korean: '��'; English: 'S'),
        (Korean: '��'; English: 'SS'),
        (Korean: '��'; English: ''),
        (Korean: '��'; English: 'J'),
        (Korean: '��'; English: 'JJ'),
        (Korean: '��'; English: 'C'),
        (Korean: '��'; English: 'K'),
        (Korean: '��'; English: 'T'),
        (Korean: '��'; English: 'P'),
        (Korean: '��'; English: 'H')
      );

      MIDDLE_LETTERS: array[0..20] of TLetter = (
        (Korean: '��'; English: 'A'),
        (Korean: '��'; English: 'AE'),
        (Korean: '��'; English: 'YA'),
        (Korean: '��'; English: 'YAE'),
        (Korean: '��'; English: 'EO'),
        (Korean: '��'; English: 'E'),
        (Korean: '��'; English: 'YEO'),
        (Korean: '��'; English: 'YE'),
        (Korean: '��'; English: 'O'),
        (Korean: '��'; English: 'WA'),
        (Korean: '��'; English: 'WAE'),
        (Korean: '��'; English: 'OE'),
        (Korean: '��'; English: 'YO'),
        (Korean: '��'; English: 'U'),
        (Korean: '��'; English: 'WEO'),
        (Korean: '��'; English: 'WE'),
        (Korean: '��'; English: 'WI'),
        (Korean: '��'; English: 'YU'),
        (Korean: '��'; English: 'EU'),
        (Korean: '��'; English: 'YI'),
        (Korean: '��'; English: 'I')
      );

      LAST_LETTERS: array[0..27] of TLetter = (
        (Korean: ''; English: ''),
        (Korean: '��'; English: 'G'),
        (Korean: '��'; English: 'GG'),
        (Korean: '��'; English: 'GS'),
        (Korean: '��'; English: 'N'),
        (Korean: '��'; English: 'NJ'),
        (Korean: '��'; English: 'NH'),
        (Korean: '��'; English: 'D'),
        (Korean: '��'; English: 'L'),
        (Korean: '��'; English: 'LG'),
        (Korean: '��'; English: 'LM'),
        (Korean: '��'; English: 'LB'),
        (Korean: '��'; English: 'LS'),
        (Korean: '��'; English: 'LT'),
        (Korean: '��'; English: 'LP'),
        (Korean: '��'; English: 'LH'),
        (Korean: '��'; English: 'M'),
        (Korean: '��'; English: 'B'),
        (Korean: '��'; English: 'BS'),
        (Korean: '��'; English: 'S'),
        (Korean: '��'; English: 'SS'),
        (Korean: '��'; English: 'NG'),
        (Korean: '��'; English: 'J'),
        (Korean: '��'; English: 'C'),
        (Korean: '��'; English: 'K'),
        (Korean: '��'; English: 'T'),
        (Korean: '��'; English: 'P'),
        (Korean: '��'; English: 'H')
      );
    {$ENDREGION}
  private
  public
    class function IsHangul(const AText: string): Boolean; static;
    class function ToEnglish(const AText: string): string; static;
  end;

implementation

{ THangul }

class function THangul.IsHangul(const AText: string): Boolean;
begin
  Result := False;
  var LChar := Word(AText[1]);
  if (LChar >= HANGUL_FIRST) and (LChar <= HANGUL_LAST) then
    Result := True;
end;

class function THangul.ToEnglish(const AText: string): string;
begin
  Result := '';
  for var i := 1 to Length(AText) do
  begin
    if IsHangul(AText[i]) then
    begin
      // �ѱ��� ��ġ���� �������� ��,��,������ �и��Ѵ�
      var LChar := Word(AText[i]) - HANGUL_FIRST;
      var LFirst := LChar div 21 div 28;
      var LMiddle := (LChar - (LFirst * 21 * 28)) div 28;
      var LLast := LChar - (LFirst * 21 * 28) - (LMiddle * 28);

      // ��,��,���� ���̺��� ã�Ƽ� �����ڷ� ��ȯ�Ѵ�
      Result := Result
        + FIRST_LETTERS[LFirst].English
        + MIDDLE_LETTERS[LMiddle].English
        + LAST_LETTERS[LLast].English;
    end
    else
    begin
      // �ѱ��� �ƴϸ� �׳� ���Ѵ�
      Result := Result + AText[i];
    end;
  end;
end;

end.
