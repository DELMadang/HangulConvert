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
        (Korean: 'ㄱ'; English: 'G'),
        (Korean: 'ㄲ'; English: 'GG'),
        (Korean: 'ㄴ'; English: 'N'),
        (Korean: 'ㄷ'; English: 'D'),
        (Korean: 'ㄸ'; English: 'DD'),
        (Korean: 'ㄹ'; English: 'R'),
        (Korean: 'ㅁ'; English: 'M'),
        (Korean: 'ㅂ'; English: 'B'),
        (Korean: 'ㅃ'; English: 'BB'),
        (Korean: 'ㅅ'; English: 'S'),
        (Korean: 'ㅆ'; English: 'SS'),
        (Korean: 'ㅇ'; English: ''),
        (Korean: 'ㅈ'; English: 'J'),
        (Korean: 'ㅉ'; English: 'JJ'),
        (Korean: 'ㅊ'; English: 'C'),
        (Korean: 'ㅋ'; English: 'K'),
        (Korean: 'ㅌ'; English: 'T'),
        (Korean: 'ㅍ'; English: 'P'),
        (Korean: 'ㅎ'; English: 'H')
      );

      MIDDLE_LETTERS: array[0..20] of TLetter = (
        (Korean: 'ㅏ'; English: 'A'),
        (Korean: 'ㅐ'; English: 'AE'),
        (Korean: 'ㅑ'; English: 'YA'),
        (Korean: 'ㅓ'; English: 'YAE'),
        (Korean: 'ㅒ'; English: 'EO'),
        (Korean: 'ㅔ'; English: 'E'),
        (Korean: 'ㅕ'; English: 'YEO'),
        (Korean: 'ㅖ'; English: 'YE'),
        (Korean: 'ㅗ'; English: 'O'),
        (Korean: 'ㅘ'; English: 'WA'),
        (Korean: 'ㅙ'; English: 'WAE'),
        (Korean: 'ㅚ'; English: 'OE'),
        (Korean: 'ㅛ'; English: 'YO'),
        (Korean: 'ㅜ'; English: 'U'),
        (Korean: 'ㅝ'; English: 'WEO'),
        (Korean: 'ㅞ'; English: 'WE'),
        (Korean: 'ㅟ'; English: 'WI'),
        (Korean: 'ㅠ'; English: 'YU'),
        (Korean: 'ㅡ'; English: 'EU'),
        (Korean: 'ㅢ'; English: 'YI'),
        (Korean: 'ㅣ'; English: 'I')
      );

      LAST_LETTERS: array[0..27] of TLetter = (
        (Korean: ''; English: ''),
        (Korean: 'ㄱ'; English: 'G'),
        (Korean: 'ㄲ'; English: 'GG'),
        (Korean: 'ㄳ'; English: 'GS'),
        (Korean: 'ㄴ'; English: 'N'),
        (Korean: 'ㄵ'; English: 'NJ'),
        (Korean: 'ㄶ'; English: 'NH'),
        (Korean: 'ㄷ'; English: 'D'),
        (Korean: 'ㄹ'; English: 'L'),
        (Korean: 'ㄺ'; English: 'LG'),
        (Korean: 'ㄻ'; English: 'LM'),
        (Korean: 'ㄼ'; English: 'LB'),
        (Korean: 'ㄽ'; English: 'LS'),
        (Korean: 'ㄾ'; English: 'LT'),
        (Korean: 'ㄿ'; English: 'LP'),
        (Korean: 'ㅀ'; English: 'LH'),
        (Korean: 'ㅁ'; English: 'M'),
        (Korean: 'ㅂ'; English: 'B'),
        (Korean: 'ㅄ'; English: 'BS'),
        (Korean: 'ㅅ'; English: 'S'),
        (Korean: 'ㅆ'; English: 'SS'),
        (Korean: 'ㅇ'; English: 'NG'),
        (Korean: 'ㅈ'; English: 'J'),
        (Korean: 'ㅊ'; English: 'C'),
        (Korean: 'ㅋ'; English: 'K'),
        (Korean: 'ㅌ'; English: 'T'),
        (Korean: 'ㅍ'; English: 'P'),
        (Korean: 'ㅎ'; English: 'H')
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
      // 한글의 위치값을 기준으로 초,중,종성을 분리한다
      var LChar := Word(AText[i]) - HANGUL_FIRST;
      var LFirst := LChar div 21 div 28;
      var LMiddle := (LChar - (LFirst * 21 * 28)) div 28;
      var LLast := LChar - (LFirst * 21 * 28) - (LMiddle * 28);

      // 초,중,종성 테이블에서 찾아서 영문자로 변환한다
      Result := Result
        + FIRST_LETTERS[LFirst].English
        + MIDDLE_LETTERS[LMiddle].English
        + LAST_LETTERS[LLast].English;
    end
    else
    begin
      // 한글이 아니면 그냥 더한다
      Result := Result + AText[i];
    end;
  end;
end;

end.
