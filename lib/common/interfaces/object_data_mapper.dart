abstract class Mapper <EncodeType, DecodeType> {
  EncodeType encode(DecodeType data);
  DecodeType decode(EncodeType data);
}